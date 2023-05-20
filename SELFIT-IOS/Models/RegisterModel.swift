//
//  RegisterModel.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-18.
//

import Foundation

struct ReqRegisterModel: Codable {
    var username: String
    var password: String
    var userType: Int
    var exerciseType: Int
    var weight: Int
    var height: Int
    var gender: Int
    var userAge: Int
    
    init(username: String = "", password: String = "", userType: Int = 0, exerciseType: Int = 0, weight: Int = 0, height: Int = 0, gender: Int = 0, userAge: Int = 0) {
        self.username = username
        self.password = password
        self.userType = userType
        self.exerciseType = exerciseType
        self.weight = weight
        self.height = height
        self.gender = gender
        self.userAge = userAge
    }
}

struct ResRegisterModel: Codable {
    let status: Bool
    let data: UserData?
    let message: String?
}

struct UserData: Codable {
    let userId: String
    let username: String
    let password: String
    let userType: Int
    let userExerciseType: Int
    let userWeight: Int
    let userHeight: Int
    let userGender: Int
    let createdAt: String
    let _id: String
    let __v: Int
}

