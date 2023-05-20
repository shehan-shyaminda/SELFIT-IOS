//
//  GenderViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-18.
//

import UIKit

class GenderViewController: UIViewController {
    let registerDataManager = RegisterDataManager.shared
    
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
        label.text = "To give you a better experience we needto know your gender"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tell Us About Yourself!"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let maleUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 0
        imageView.image = UIImage(imageLiteralResourceName: "ic_selectedMale")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let femaleUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 1
        imageView.image = UIImage(imageLiteralResourceName: "ic_unSelectedFemale")
        imageView.clipsToBounds = true
        return imageView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDataManager.registerModel.gender = 0
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(hintLabel)
        containerStackView.addArrangedSubview(titleStackView)
        selectionStackView.addArrangedSubview(maleUIImage)
        selectionStackView.addArrangedSubview(femaleUIImage)
        containerStackView.addArrangedSubview(selectionStackView)
        containerStackView.addArrangedSubview(nextButton)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        nextButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let tapSelectionMale = UITapGestureRecognizer(target: self, action: #selector(selectionTapped(_:)))
        let tapSelectionFemale = UITapGestureRecognizer(target: self, action: #selector(selectionTapped(_:)))
        maleUIImage.isUserInteractionEnabled = true
        maleUIImage.addGestureRecognizer(tapSelectionMale)
        femaleUIImage.isUserInteractionEnabled = true
        femaleUIImage.addGestureRecognizer(tapSelectionFemale)
    }
    
    func setupSnaps() {
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.10)
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
        navigateToViewController(AgeViewController(), from: self.navigationController)
    }
    
    @objc func selectionTapped(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        switch imageView.tag {
        case 0:
            changeSelection(tag: imageView.tag)
        case 1:
            changeSelection(tag: imageView.tag)
        default:
            changeSelection(tag: imageView.tag)
        }
    }
    
    func changeSelection(tag: Int) {
        switch tag {
        case 0:
            registerDataManager.registerModel.gender = 0
            maleUIImage.image = UIImage(named: "ic_selectedMale")
            femaleUIImage.image = UIImage(named: "ic_unSelectedFemale")
        case 1:
            registerDataManager.registerModel.gender = 1
            maleUIImage.image = UIImage(named: "ic_unSelectedMale")
            femaleUIImage.image = UIImage(named: "ic_selectedFemale")
        default:
            registerDataManager.registerModel.gender = 0
            maleUIImage.image = UIImage(named: "ic_selectedMale")
            femaleUIImage.image = UIImage(named: "ic_unSelectedFemale")
        }
    }
}
