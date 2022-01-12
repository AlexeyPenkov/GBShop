//
//  Auth.swift
//  GBShop
//
//  Created by Алексей Пеньков on 12.01.2022.
//

import Alamofire

class Auth: AbstractRequestFactory {
    var errorParser: AbstractErrorParser
    
    var sessionManager: Session
    
    var queue: DispatchQueue
    
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = .global(qos: .utility)) {
            self.errorParser = errorParser
            self.sessionManager = sessionManager
            self.queue = queue
        }
}

extension Auth: AuthRequestFactory {
    func login(userName: String, password: String, completionHadler: @escaping (AFDataResponse<LoginResult>) -> Void) {
        let requestModel = Login(baseUrl: baseUrl, login: userName, password: password)
        self.request(request: requestModel, completionHandler: completionHadler)
    }
}

extension Auth {
    struct Login: RequestRouter {
        var baseUrl: URL
        
        var method: HTTPMethod = .get
        
        var path: String = "login.json"
        
        let login: String
        
        let password: String
        
        var parameters: Parameters? {
            return [
                "username": login,
                "password": password]
        }
        
        
    }
}
