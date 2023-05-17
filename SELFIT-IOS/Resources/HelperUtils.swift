//
//  HelperUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-16.
//

import Foundation
import UIKit

func changeRootViewController(controller: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let keyWindow = windowScene.windows.first else {
        return
    }
    UIView.transition(with: keyWindow, duration: 0.3, options: .transitionCrossDissolve, animations: {
        keyWindow.rootViewController = controller
    }, completion: nil)
}
