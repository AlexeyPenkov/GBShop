//
//  AbstractErrorParser.swift
//  GBShop
//
//  Created by Алексей Пеньков on 12.01.2022.
//

import Foundation

protocol AbstractErrorParser {
    func parse(_ result: Error) -> Error
    func parse(response: HTTPURLResponse?, data: Data?, error: Error?) -> Error?
}
