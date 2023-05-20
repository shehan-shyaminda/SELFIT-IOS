//
//  HelperUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-16.
//

import Foundation
import UIKit

func changeRootViewController(_ viewController: UIViewController) {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let keyWindow = windowScene.windows.first else {
        return
    }
    UIView.transition(with: keyWindow, duration: 0.3, options: .transitionCrossDissolve, animations: {
        keyWindow.rootViewController = viewController
    }, completion: nil)
}

func navigateToViewController(_ viewController: UIViewController, from navigationController: UINavigationController?) {
    navigationController?.pushViewController(viewController, animated: true)
}

func popViewController(_ viewController: UIViewController) {
    if let navigationController = viewController.navigationController {
        navigationController.popViewController(animated: true)
    } else {
        viewController.dismiss(animated: true, completion: nil)
    }
}

func popToRootViewController(_ navigationController: UINavigationController, completion: (() -> Void)? = nil) {
    navigationController.popToRootViewController(animated: true)
    completion?()
}

func removeAllSubviewsExcept(from view: UIView, except exceptView: UIView) {
    for subview in view.subviews {
        if subview != exceptView {
            subview.removeFromSuperview()
        }
    }
}
