//
//  SnakbarUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-18.
//

import Foundation
import UIKit
import SnapKit

class SnackbarView: UIView {
    private let titleLabel: UILabel
    private let duration: TimeInterval
    
    init(title: String, duration: TimeInterval) {
        self.titleLabel = UILabel()
        self.duration = duration
        
        super.init(frame: .zero)
        
        configureView()
        configureConstraints()
        setTitle(title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = UIColor.black
        layer.cornerRadius = 8.0
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 16.0)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        addSubview(titleLabel)
    }
    
    private func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(25)
        }
    }
    
    private func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func show(from view: UIView) {
        alpha = 0.0
        view.addSubview(self)
        
        snp.makeConstraints { [self] make in
            make.leading.equalToSuperview().offset(16.0)
            make.trailing.equalToSuperview().offset(-16.0)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16.0)
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 1.0
        } completion: { [self] _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [self] in
                hide()
            }
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3) { [self] in
            alpha = 0.0
        } completion: { [self] _ in
            removeFromSuperview()
        }
    }
}

