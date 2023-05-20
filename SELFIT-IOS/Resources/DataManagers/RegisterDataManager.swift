//
//  RegisterDataManager.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-20.
//

import Foundation
 
class RegisterDataManager {
    static let shared = RegisterDataManager()
    var registerModel = ReqRegisterModel()

    private init() {}

    func clearRegisterModel() {
        registerModel = ReqRegisterModel()
    }
}
