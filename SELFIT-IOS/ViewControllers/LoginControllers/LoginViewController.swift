//
//  LoginViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-15.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import Combine

class LoginViewController: UIViewController {
    let networkManager = NetworkManager()
    
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
        imageView.image = UIImage(imageLiteralResourceName: "Frame_6")
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
        button.layer.cornerRadius = 25
        return button
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome Back"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "SIGN IN"
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
    
    let newUserUILabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleUIStack.addArrangedSubview(hintLabel)
        titleUIStack.addArrangedSubview(titleLabel)
        hintUIImage.addSubview(titleUIStack)
        containerStackView.addArrangedSubview(hintUIImage)
        containerStackView.addArrangedSubview(inputUsername)
        containerStackView.addArrangedSubview(inputPassword)
        containerStackView.addArrangedSubview(newUserUILabel)
        containerStackView.addArrangedSubview(nextButton)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        let newUserTxt = "Don't have an account? Sign up"
        let attributedString = NSMutableAttributedString(string: newUserTxt)
        let range = (newUserTxt as NSString).range(of: "Sign up")
        attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Primary_Green")!, range: range)
        newUserUILabel.attributedText = attributedString
        
        newUserUILabel.isUserInteractionEnabled = true
        let tapNavLog = UITapGestureRecognizer(target: self, action: #selector(navLogTapped(_:)))
        newUserUILabel.addGestureRecognizer(tapNavLog)
        
        nextButton.isPointerInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
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
        
        newUserUILabel.snp.makeConstraints{ make in
            make.height.equalTo(20)
            make.leading.equalToSuperview().inset(25)
        }
    }
    
    @objc func navLogTapped(_ gesture: UITapGestureRecognizer) {
        navigateToViewController(RegisterViewController(), from: self.navigationController)
    }
    
    @objc func loginTapped() {
        AlertUtils.startAnimate(in: self, animationType: .ballTrianglePath)
        let username = inputUsername.text ?? ""
        let password = inputPassword.text ?? ""
//        let data = [
//            "username": username,
//            "password": password
//        ]
        let data = ReqLoginModel(username: username, password: password)
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode JSON data")
            return
        }
        networkManager.performNetworkCall(NetworkManager.login_URL, httpMethod: .post, httpBody: jsonData) { [self] (result: Result<ResLoginModel, Error>) in
            switch result {
            case .success(let res):
                if res.status {
                    UserDefaults.standard.set(res.data?.userId, forKey: "userId")
                    UserDefaults.standard.set(res.data?.access_token, forKey: "accessToken")
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        changeRootViewController(MainViewController())
                    }
                } else {
                    print(res.message!)
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        let snackbar = SnackbarView(title: "Oops! Please check yout credentials.", duration: 3.0)
                        snackbar.show(from: self.view)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    AlertUtils.dismissAnimate()
                }
            }
        }
    }
}

struct ResLoginModel: Decodable {
    let status: Bool
    let data: LoginData?
    let message: String?
}

struct LoginData: Decodable {
    let userId, access_token: String
}

struct ReqLoginModel: Codable {
    let username: String
    let password: String
}
