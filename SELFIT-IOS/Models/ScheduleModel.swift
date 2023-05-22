//
//  ScheduleModel.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-21.
//

import Foundation

struct ReqScheduleModel: Codable {
    var scheduleId: String
    var asDictionary: [String: String] {
            return [
                "scheduleId": scheduleId
            ]
        }
}

struct ResScheduleData: Decodable {
    let status: Bool
    let data: [Schedules]
}

struct Schedules: Decodable {
    let id: String
    let scheduleId: String
    let scheduleName: String
    let scheduleUserType: Int
    let scheduleType: Int
    let scheduleGender: Int
    let scheduleBannerURL: String
    let scheduleList: [String]
    let isCustomSchedule: String
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case scheduleId
        case scheduleName
        case scheduleUserType
        case scheduleType
        case scheduleGender
        case scheduleBannerURL
        case scheduleList
        case isCustomSchedule
        case version = "__v"
    }
}
