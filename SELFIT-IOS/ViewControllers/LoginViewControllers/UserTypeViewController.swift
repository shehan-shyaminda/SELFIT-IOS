//
//  UserTypeViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-20.
//

import UIKit

class UserTypeViewController: UIViewController {
    let networkManager = NetworkManager()
    let registerDataManager = RegisterDataManager.shared
    var data: [String] = ["Beginner", "Intermediate", "Expert"]
    
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
    
    let titleStackView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .equalSpacing
        containterStack.alignment = .center
        return containterStack
    }()
    
    let selectionStackView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .fillEqually
        containterStack.alignment = .center
        containterStack.spacing = 20
        return containterStack
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "This helps us create your personalized plan"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your regular physical activity level?"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
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
    
    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        registerDataManager.registerModel.userType = 1
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(hintLabel)
        containerStackView.addArrangedSubview(titleStackView)
        selectionStackView.addArrangedSubview(pickerView)
        containerStackView.addArrangedSubview(selectionStackView)
        containerStackView.addArrangedSubview(nextButton)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
               
       if let selectedIndex = data.firstIndex(of: "Intermediate") {
           pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
       }
    }
    
    func setupSnaps() {
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.15)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func nextTapped(){
        print(registerDataManager.registerModel)
        AlertUtils.startAnimate(in: self, animationType: .ballTrianglePath)
        let data = registerDataManager.registerModel
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode JSON data")
            return
        }
        networkManager.performNetworkCall(NetworkManager.register_url, httpMethod: .post, httpBody: jsonData) { [self] (result: Result<ResRegisterModel, Error>) in
            switch result {
            case .success(let res):
                if res.status {
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        self.registerDataManager.clearRegisterModel()
                        navigateToViewController(LoginViewController(), from: self.navigationController)
                    }
                } else {
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        let snackbar = SnackbarView(title: res.message ?? "Oops! Something went wrong.", duration: 3.0)
                        snackbar.show(from: self.view)
                    }
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    AlertUtils.dismissAnimate()
                    self.registerDataManager.clearRegisterModel()
                }
            }
        }
    }
}


extension UserTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected option: \(String(data[row]))")
        registerDataManager.registerModel.userType = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.text = String(data[row])
        label.textColor = UIColor(named: "Primary_Green")
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}
