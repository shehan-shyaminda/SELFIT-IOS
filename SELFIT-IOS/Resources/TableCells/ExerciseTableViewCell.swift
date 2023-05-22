//
//  ExerciseTableViewCell.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {
    
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
        containterStack.layer.cornerRadius = 25
        containterStack.clipsToBounds = true
        return containterStack
    }()
    
    let hintUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageLiteralResourceName: "Frame_7")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let focusedArea: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let focusedCalories: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let userType: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 10)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let genderType: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 10)
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
    
    
    override func didMoveToSuperview() {
        titleUIStack.addArrangedSubview(exerciseNameLabel)
        titleUIStack.addArrangedSubview(focusedArea)
        titleUIStack.addArrangedSubview(focusedCalories)
        titleUIStack.addArrangedSubview(userType)
        titleUIStack.addArrangedSubview(genderType)
        hintUIImage.addSubview(titleUIStack)
        containerStackView.addArrangedSubview(hintUIImage)
        containerUIView.addSubview(containerStackView)
        contentView.addSubview(containerUIView)
        
        setupSnaps()
    }
    
    func setupSnaps() {
        hintUIImage.snp.makeConstraints{(make) -> Void in
            make.edges.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleUIStack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
}
