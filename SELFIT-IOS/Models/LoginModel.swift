//
//  LoginModel.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-18.
//

import Foundation


struct ReqLoginModel: Codable {
    var username: String
    var password: String
}

struct ResLoginModel: Decodable {
    let status: Bool
    let data: LoginData?
    let message: String?
}

struct LoginData: Decodable {
    let userId, access_token: String
}
