//
//  WalktroughViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-13.
//

import UIKit
import SnapKit

class WalktroughViewController: UIViewController {
    
    var selectedHint: Int = 0
    var imageList = ["Frame_0", "Frame_1", "Frame_2"]
    var quoteList = ["Meet your coach,\nstart your journey", "Create a workout plan\nto stay fit", "Action is the\nkey to all success"]
    var quoteHighlitedList = ["start your journey", "to stay fit", "key to all success"]
    
    let hintUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageLiteralResourceName: "Frame_0")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "Meet your coach,\nstart your journey"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let selectedIndicator_hint1: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.spacing = 15
        containterStack.frame.size.width = 10
        containterStack.frame.size.height = 5
        containterStack.layer.cornerRadius = 5
        containterStack.backgroundColor = UIColor(named: "Primary_Gray")
        return containterStack
    }()
    
    let selectedIndicator_hint2: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.spacing = 15
        containterStack.frame.size.width = 10
        containterStack.frame.size.height = 5
        containterStack.layer.cornerRadius = 5
        containterStack.backgroundColor = UIColor(named: "Primary_Gray")
        return containterStack
    }()
    
    let selectedIndicator_hint3: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.spacing = 15
        containterStack.frame.size.width = 10
        containterStack.frame.size.height = 5
        containterStack.layer.cornerRadius = 5
        containterStack.backgroundColor = UIColor(named: "Primary_Gray")
        return containterStack
    }()
    
    let indicatorStack: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .horizontal
        containterStack.distribution = .fillEqually
        containterStack.spacing = 10
        return containterStack
    }()
    
    let containerVStack: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.alignment = .center
        containterStack.distribution = .fill
        containterStack.spacing = 10
        return containterStack
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        
        self.hintUIImage.image = UIImage(imageLiteralResourceName: self.imageList[0])
        let attributedText = NSMutableAttributedString(string: self.quoteList[0])
        let range = (self.quoteList[0] as NSString?)?.range(of: self.quoteHighlitedList[0]) ?? NSRange(location: 0, length: 0)
        attributedText.addAttribute(.font, value: UIFont.init(name: "IntegralCF-Bold", size: hintLabel.font.pointSize) as Any, range: range)
        hintLabel.attributedText = attributedText
        self.selectedIndicator_hint1.backgroundColor = UIColor(named: "Primary_Green")
        
        indicatorStack.addArrangedSubview(selectedIndicator_hint1)
        indicatorStack.addArrangedSubview(selectedIndicator_hint2)
        indicatorStack.addArrangedSubview(selectedIndicator_hint3)
        
        containerVStack.addArrangedSubview(hintUIImage)
        containerVStack.addArrangedSubview(hintLabel)
        containerVStack.addArrangedSubview(indicatorStack)
        
        view.addSubview(containerVStack)
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeftGesture))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRightGesture))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
        
        setupSnaps()
    }
    
    func setupSnaps(){
        hintUIImage.snp.makeConstraints{(make) -> Void in
            make.height.equalTo(view.snp.height).multipliedBy(0.75)
        }
        
        indicatorStack.snp.makeConstraints{(make) -> Void in
            make.width.equalTo(view.snp.width).multipliedBy(0.50)
            make.height.equalTo(8)
        }
        
        containerVStack.snp.makeConstraints { (make) -> Void in
            make.height.equalToSuperview().offset(-50)
            make.width.equalToSuperview()
        }
    }
    
    @objc func handleSwipeLeftGesture() {
        UIView.animate(withDuration: 0.5, animations: {
            if (self.selectedHint != 2) {
                self.hintUIImage.alpha = 0.5
                self.hintLabel.alpha = 0.5
                self.selectedHint += 1
            } else {
                UserDefaults.standard.set(true, forKey: "isExistingUser")
                self.gotToNext()
            }
        }, completion: { finished in
            if finished {
                self.changeUIImageHint()
                self.hintUIImage.alpha = 1
                self.hintLabel.alpha = 1
            }
        })
    }
    
    @objc func handleSwipeRightGesture() {
        UIView.animate(withDuration: 0.5, animations: {
            if (self.selectedHint != 0) {
                self.hintUIImage.alpha = 0.5
                self.hintLabel.alpha = 0.5
                self.selectedHint -= 1
            }
        }, completion: { finished in
            if finished {
                self.changeUIImageHint()
                self.hintUIImage.alpha = 1
                self.hintLabel.alpha = 1
            }
        })
    }
    
    @objc func gotToNext(){
        navigateToViewController(LoginViewController(), from: self.navigationController)
    }
    
    func changeUIImageHint(){
        var attributedText: NSMutableAttributedString!
        var range: NSRange!
        
        switch selectedHint {
        case 0:
            self.hintUIImage.image = UIImage(imageLiteralResourceName: self.imageList[0])
            attributedText = NSMutableAttributedString(string: self.quoteList[0])
            range = (self.quoteList[0] as NSString?)?.range(of: self.quoteHighlitedList[0]) ?? NSRange(location: 0, length: 0)
            self.selectedIndicator_hint1.backgroundColor = UIColor(named: "Primary_Green")
            self.selectedIndicator_hint2.backgroundColor = UIColor(named: "Primary_Gray")
            self.selectedIndicator_hint3.backgroundColor = UIColor(named: "Primary_Gray")
        case 1:
            self.hintUIImage.image = UIImage(imageLiteralResourceName: self.imageList[1])
            attributedText = NSMutableAttributedString(string: self.quoteList[1])
            range = (self.quoteList[1] as NSString?)?.range(of: self.quoteHighlitedList[1]) ?? NSRange(location: 0, length: 0)
            self.selectedIndicator_hint1.backgroundColor = UIColor(named: "Primary_Green")
            self.selectedIndicator_hint2.backgroundColor = UIColor(named: "Primary_Green")
            self.selectedIndicator_hint3.backgroundColor = UIColor(named: "Primary_Gray")
        case 2:
            self.hintUIImage.image = UIImage(imageLiteralResourceName: self.imageList[2])
            attributedText = NSMutableAttributedString(string: self.quoteList[2])
            range = (self.quoteList[2] as NSString?)?.range(of: self.quoteHighlitedList[2]) ?? NSRange(location: 0, length: 0)
            self.selectedIndicator_hint1.backgroundColor = UIColor(named: "Primary_Green")
            self.selectedIndicator_hint2.backgroundColor = UIColor(named: "Primary_Green")
            self.selectedIndicator_hint3.backgroundColor = UIColor(named: "Primary_Green")
        default:
            self.hintUIImage.image = UIImage(imageLiteralResourceName: self.imageList[0])
            attributedText = NSMutableAttributedString(string: self.quoteList[0])
            range = (self.quoteList[0] as NSString?)?.range(of: self.quoteHighlitedList[0]) ?? NSRange(location: 0, length: 0)
            self.selectedIndicator_hint1.backgroundColor = UIColor(named: "Primary_Green")
        }
        
        attributedText.addAttribute(.font, value: UIFont.init(name: "IntegralCF-Bold", size: hintLabel.font.pointSize) as Any, range: range)
        hintLabel.attributedText = attributedText
    }
}
