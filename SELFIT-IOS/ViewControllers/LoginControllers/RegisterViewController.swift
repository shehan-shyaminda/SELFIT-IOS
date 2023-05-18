//
//  RegisterViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-15.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class RegisterViewController: UIViewController {
    
    let containerUIView: UIView = {
        let containterStack = UIView()
        containterStack.backgroundColor = UIColor(named: "Background")
        return containterStack
    }()
    
    let containerStackView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .fill
        containterStack.alignment = .center
        containterStack.spacing = 30
        return containterStack
    }()
    
    let hintUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageLiteralResourceName: "Frame_7")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let inputUsername: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "Email Address"
        textField.placeholder = "Email Address"
        textField.selectedTitleColor = UIColor(named: "Primary_Green")!
        return textField
    }()
    
    let inputPassword: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.title = "Password"
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.selectedTitleColor = UIColor(named: "Primary_Green")!
        return textField
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next ➤", for: .normal)
        button.backgroundColor = UIColor(named: "Primary_Green")
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(named: "Primary_Orange"), for: .highlighted)
        button.layer.cornerRadius = 25
        return button
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "HELLO ROOKIES"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN UP"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleUIStack: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .fill
        containterStack.alignment = .leading
        containterStack.spacing = 10
        return containterStack
    }()
    
    let existingUserUILabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationItem.hidesBackButton = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleUIStack.addArrangedSubview(hintLabel)
        titleUIStack.addArrangedSubview(titleLabel)
        hintUIImage.addSubview(titleUIStack)
        containerStackView.addArrangedSubview(hintUIImage)
        containerStackView.addArrangedSubview(inputUsername)
        containerStackView.addArrangedSubview(inputPassword)
        containerStackView.addArrangedSubview(existingUserUILabel)
        containerStackView.addArrangedSubview(nextButton)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        let existingUserTxt = "Already have an account? Sign in"
        let attributedString = NSMutableAttributedString(string: existingUserTxt)
        let range = (existingUserTxt as NSString).range(of: "Sign in")
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Primary_Green")!, range: range)
        existingUserUILabel.attributedText = attributedString
        
        existingUserUILabel.isUserInteractionEnabled = true
        let tapNavLog = UITapGestureRecognizer(target: self, action: #selector(navLogTapped(_:)))
        existingUserUILabel.addGestureRecognizer(tapNavLog)
    }
    
    func setupSnaps() {
        inputUsername.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        inputPassword.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.leading.equalToSuperview().inset(25)
            make.trailing.equalToSuperview().inset(25)
        }
        
        hintUIImage.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.top.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.width.equalToSuperview().inset(30)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(60)
        }
        
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleUIStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        existingUserUILabel.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.leading.equalToSuperview().inset(25)
        }
    }
    
    @objc func navLogTapped(_ gesture: UITapGestureRecognizer) {
        popViewController(self)
    }
}
