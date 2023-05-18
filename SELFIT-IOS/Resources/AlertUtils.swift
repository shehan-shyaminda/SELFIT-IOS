//
//  AlertUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-18.
//

import Foundation
import UIKit
import SnapKit
import NVActivityIndicatorView
import SnackBar

class AlertUtils {
    private static var overlayView: UIView?
    
    static func startAnimate(in viewController: UIViewController, loadingText: String = "", animationType: NVActivityIndicatorType = .ballScaleRippleMultiple) {
        guard overlayView == nil else {
            return
        }
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        viewController.view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let loadingView = UIView()
        containerView.addSubview(loadingView)
        
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        let activityIndicatorView = NVActivityIndicatorView(
            frame: CGRect(x: 0, y: 0, width: 60, height: 60),
            type: animationType,
            color: .white,
            padding: nil
        )
        loadingView.addSubview(activityIndicatorView)
        
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        let loadingLabel = UILabel()
        loadingLabel.text = loadingText
        loadingLabel.textColor = .white
        loadingLabel.textAlignment = .center
        loadingView.addSubview(loadingLabel)
        
        loadingLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(activityIndicatorView.snp.bottom).offset(10)
            make.bottom.equalToSuperview()
        }
        
        activityIndicatorView.startAnimating()
        
        overlayView = containerView
    }
    
    static func dismissAnimate() {
        overlayView?.removeFromSuperview()
        overlayView = nil
    }
    
    static func showAlert(in viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
