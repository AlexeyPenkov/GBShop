//
//  ErrorParserStub.swift
//  GBShopTests
//
//  Created by Алексей Пеньков on 14.01.2022.
//

import Foundation

struct ErrorParserStub: AbstractErrorParser {
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
    func parse(_ result: Error) -> Error {
        return ApiErrorStub.fatalError
    }
}
