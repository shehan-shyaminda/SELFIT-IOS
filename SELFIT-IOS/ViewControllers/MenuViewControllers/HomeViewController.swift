//
//  HomeViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-15.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let newUserUILabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(newUserUILabel)
        let tapNavLog = UITapGestureRecognizer(target: self, action: #selector(navLogTapped(_:)))
        newUserUILabel.addGestureRecognizer(tapNavLog)
        
        newUserUILabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.bringSubviewToFront(newUserUILabel)
    }
    
    @objc func navLogTapped(_ gesture: UITapGestureRecognizer) {
        navigateToViewController(SetSheduleViewController(), from: self.navigationController)
    }
}
