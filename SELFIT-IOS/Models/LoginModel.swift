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
    let user: UserDetails
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case user
        case accessToken = "access_token"
    }
}

struct UserDetails: Decodable {
    let id: String
    let userId: String
    let username: String
    let password: String
    let userType: Int
    let userExerciseType: Int
    let userWeight: Int
    let userHeight: Int
    let userGender: Int
    let createdAt: String
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userId
        case username
        case password
        case userType
        case userExerciseType
        case userWeight
        case userHeight
        case userGender
        case createdAt
        case version = "__v"
    }
}
