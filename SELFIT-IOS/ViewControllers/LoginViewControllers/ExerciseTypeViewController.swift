//
//  ExerciseTypeViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-20.
//

import UIKit

class ExerciseTypeViewController: UIViewController {
    let registerDataManager = RegisterDataManager.shared
    var data: [String] = ["Cardio", "Weight Gaining", "Weight Loosing"]
    
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
        label.text = "What’s your goal?"
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
        registerDataManager.registerModel.exerciseType = 1
        
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
        
        if let selectedIndex = data.firstIndex(of: "Weight Gaining") {
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
        navigateToViewController(UserTypeViewController(), from: self.navigationController)
    }
}

extension ExerciseTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected option: \(String(data[row]))")
        registerDataManager.registerModel.exerciseType = row
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.text = String(data[row])
        label.textColor = UIColor(named: "Primary_Green")
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }
}
