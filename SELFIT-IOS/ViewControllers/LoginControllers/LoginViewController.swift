//
//  LoginViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-15.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class LoginViewController: UIViewController {
    
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
        imageView.image = UIImage(imageLiteralResourceName: "Frame_4")
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
        button.setTitle("Login ➤", for: .normal)
        button.backgroundColor = UIColor(named: "Primary_Green")
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(UIColor(named: "Primary_Orange"), for: .highlighted)
        button.layer.cornerRadius = 15
        return button
    }()
    
    let loginNavUIView: UILabel = {
        let containterStack = UILabel()
        containterStack.textAlignment = .center
        containterStack.text = "SIGN IN"
        containterStack.textColor = .white
        containterStack.layer.borderWidth = 1
        containterStack.layer.borderColor = UIColor(named: "Primary_Green")?.cgColor
        return containterStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintUIImage.addSubview(loginNavUIView)
        containerStackView.addArrangedSubview(hintUIImage)
        containerStackView.addArrangedSubview(inputUsername)
        containerStackView.addArrangedSubview(inputPassword)
        containerStackView.addArrangedSubview(nextButton)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
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
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(30)
        }
        
        hintUIImage.snp.makeConstraints{(make) -> Void in
            make.width.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginNavUIView.snp.makeConstraints{ make in
            make.top.equalTo(60)
            make.leading.equalTo(50)
        }
    }
}
