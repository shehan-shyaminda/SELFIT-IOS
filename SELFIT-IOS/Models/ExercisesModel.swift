//
//  ExercisesModel.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import Foundation

struct ReqExercise: Codable {
    var exerciseId: String
    var asDictionary: [String: String] {
            return [
                "exerciseId": exerciseId
            ]
        }
}

struct ResExercise: Decodable {
    let status: Bool
    let data: [Exercise]
}

struct Exercise: Decodable {
    let id: String
    let exerciseId: String
    let exerciseName: String
    let exerciseDuration: Int
    let exerciseMeasureType: String
    let userType: Int
    let exerciseType: Int
    let exerciseGender: Int
    let focusedArea: String
    let exerciseCalories: Int
    let exerciseBannerURL: String
    let maxDuration: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case exerciseId
        case exerciseName
        case exerciseDuration
        case exerciseMeasureType
        case userType
        case exerciseType
        case exerciseGender
        case focusedArea
        case exerciseCalories
        case exerciseBannerURL
        case maxDuration = "exerciseMaxDuration"
    }
}
