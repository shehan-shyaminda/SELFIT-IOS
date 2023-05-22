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

func getUserType(_ type: Int) -> String {
    switch type {
    case 0:
        return "Beginner"
    case 1:
        return "Intermidiate"
    case 2:
        return "Expert"
    default:
        return "Beginner"
    }
}

func getExercisesType(_ type: Int) -> String {
    switch type {
    case 0:
        return "Cardio"
    case 1:
        return "Weight Gaining"
    case 2:
        return "Weight Loosing"
    default:
        return "Cardio"
    }
}

func getGender(_ type: Int) -> String {
    switch type {
    case 0:
        return "Male"
    case 1:
        return "Female"
    default:
        return "Male"
    }
}

func getFocusedArea(_ type: String) -> String {
    switch type {
    case "0":
        return "Chest"
    case "1":
        return "Back"
    case "2":
        return "Arms"
    case "3":
        return "Abdominal"
    case "4":
        return "Legs"
    case "5":
        return "Shoulders"
    default:
        return "Chest"
    }
}

func adjustImageOpacity(image: UIImage?, opacity: CGFloat) -> UIImage? {
    guard let image = image else {
        return nil
    }
    
    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
    let context = UIGraphicsGetCurrentContext()
    let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
    
    context?.scaleBy(x: 1, y: -1)
    context?.translateBy(x: 0, y: -rect.size.height)
    context?.setBlendMode(.multiply)
    context?.setAlpha(opacity)
    context?.draw(image.cgImage!, in: rect)
    
    let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return modifiedImage
}
