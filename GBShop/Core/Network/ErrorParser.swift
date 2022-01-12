//
//  ErrorParser.swift
//  GBShop
//
//  Created by Алексей Пеньков on 12.01.2022.
//

import Foundation

class ErrorParser: AbstractErrorParser {
    func parse(_ result: Error) -> Error {
        return result
    }
    
    func parse(responce: HTTPURLResponse?, data: Data?, error: Error?) -> Error? {
        return error
    }
    
    
}
