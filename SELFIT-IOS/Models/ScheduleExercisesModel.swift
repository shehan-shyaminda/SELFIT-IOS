//
//  ScheduleExercisesModel.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import Foundation

struct ReqScheduleExercises: Codable {
    var scheduleList: [String]
}

struct ResScheduleExecises: Decodable {
    let status: Bool
    let data: [Exercise]
}
