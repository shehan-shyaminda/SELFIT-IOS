//
//  HelperUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-16.
//

import Foundation
import UIKit

func changeRootViewController(controller: UIViewController) {
    let newRootViewController = controller

    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
        return
    }

    // Set the new root view controller
    sceneDelegate.window?.rootViewController = newRootViewController

    // Make the window visible
    sceneDelegate.window?.makeKeyAndVisible()
}
