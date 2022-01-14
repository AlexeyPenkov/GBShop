//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Алексей Пеньков on 12.01.2022.
//

import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHadler: @escaping (AFDataResponse<LoginResult>) -> Void)
}
