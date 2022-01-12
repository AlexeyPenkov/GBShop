//
//  DataRequest.swift
//  GBShop
//
//  Created by Алексей Пеньков on 12.01.2022.
//

import Foundation
import Alamofire

class CustomDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {
    
    private let errorParser: AbstractErrorParser
    
    init(errorParser: AbstractErrorParser) {
        self.errorParser = errorParser
    }
    
    func serialize(request: URLRequest?, responce: HTTPURLResponse?, data: Data?, error: Error?) throws -> T {
        if let error = errorParser.parse(responce: responce, data: data, error: error) {
            throw error
        }
        do {
            let data = try DataResponseSerializer().serialize(request: request, response: responce, data: data, error: error)
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            let customError = errorParser.parse(error)
            throw customError
        }
            
    }
}

extension DataRequest {
    @discardableResult
    func responceCodable<T: Decodable>(
        errorParser: AbstractErrorParser,
        queue: DispatchQueue = .main,
        completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        let responceSerializer = CustomDecodableSerializer<T>(errorParser: errorParser)
        return response(queue: queue, responseSerializer: responceSerializer, completionHandler: completionHandler)
    }
}

protocol AbstractRequestFactory {
    var errorParser: AbstractErrorParser { get }
    var sessionManager: Session { get }
    var queue: DispatchQueue { get }
    
    @discardableResult
    
    func request<T: Decodable>(
        request:URLRequestConvertible,
        completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest
    
}

extension AbstractRequestFactory {
    @discardableResult
    public func request<T: Decodable>(
                request: URLRequestConvertible,
                completionHandler: @escaping (AFDataResponse<T>) -> Void) -> DataRequest {
                    return sessionManager
                        .request(request)
                        .responceCodable(errorParser: errorParser, queue: queue, completionHandler: completionHandler)
                }
}
