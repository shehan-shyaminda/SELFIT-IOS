//
//  HomeTableViewCell.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
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
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = "7 Day Pushup Challenge"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Users Types: Intermidiate"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 16)
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
        titleUIStack.addArrangedSubview(hintLabel)
        titleUIStack.addArrangedSubview(titleLabel)
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
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
    }
}
