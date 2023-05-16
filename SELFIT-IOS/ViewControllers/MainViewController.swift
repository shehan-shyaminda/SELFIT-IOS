//
//  MainViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-12.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let Home = HomeViewController()
    let Stats = LoginViewController()
    let Me = RegisterViewController()
    
    let containerUIView: UIView = {
        let containterStack = UIView()
        containterStack.backgroundColor = UIColor(named: "Background")
        return containterStack
    }()
    
    let botmNavUIView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.backgroundColor = .gray
        containterStack.axis = .horizontal
        containterStack.distribution = .equalCentering
        containterStack.spacing = 10
        containterStack.alignment = .center
        return containterStack
    }()
    
    let tabHome: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tag = 0
        imageView.image = UIImage(named: "Home_selected")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tabStats: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tag = 1
        imageView.image = UIImage(named: "Stats_selected")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let tabMe: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tag = 2
        imageView.image = UIImage(named: "Me_selected")
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        botmNavUIView.addArrangedSubview(tabHome)
        botmNavUIView.addArrangedSubview(tabStats)
        botmNavUIView.addArrangedSubview(tabMe)
        containerUIView.addSubview(botmNavUIView)
        view.addSubview(containerUIView)
        
        initiateNavigationPanel(tab: .Home)
        
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        botmNavUIView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-30)
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(60)
        }
        
        tabHome.snp.makeConstraints{ make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        tabStats.snp.makeConstraints{ make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        tabMe.snp.makeConstraints{ make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        botmNavUIView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        botmNavUIView.isLayoutMarginsRelativeArrangement = true
        containerUIView.bringSubviewToFront(botmNavUIView)
        botmNavUIView.layer.cornerRadius = 15
        botmNavUIView.layer.shadowColor = UIColor.black.cgColor
        botmNavUIView.layer.shadowOffset = CGSize(width: 0, height: 2)
        botmNavUIView.layer.shadowOpacity = 0.4
        botmNavUIView.layer.shadowRadius = 4
        
        let tapNavGestureHome = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
        let tapNavGestureStats = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
        let tapNavGestureMe = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
        tabHome.addGestureRecognizer(tapNavGestureHome)
        tabStats.addGestureRecognizer(tapNavGestureStats)
        tabMe.addGestureRecognizer(tapNavGestureMe)
    }
    
    func initiateNavigationPanel(tab: NavigationTabs){
        changeSelectedTab(tab: .Home)
        switch tab {
        case .Home:
            containerUIView.addSubview(Home.view)
            addChild(Home)
            Home.didMove(toParent: self)
            Home.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        case .Stats:
            containerUIView.addSubview(Stats.view)
            addChild(Stats)
            Stats.didMove(toParent: self)
            Stats.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
        case .Me:
            containerUIView.addSubview(Me.view)
            addChild(Me)
            Me.didMove(toParent: self)
            Me.view.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        containerUIView.bringSubviewToFront(botmNavUIView)
    }
    
    
    @objc func handleNavigationPanel(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        
        print(imageView.tag)
        switch imageView.tag {
        case 0:
            print("Home")
            initiateNavigationPanel(tab: .Home)
            changeSelectedTab(tab: .Home)
        case 1:
            print("Stats")
            initiateNavigationPanel(tab: .Stats)
            changeSelectedTab(tab: .Stats)
        case 2:
            print("Me")
            initiateNavigationPanel(tab: .Me)
            changeSelectedTab(tab: .Me)
        default:
            print("Default")
            initiateNavigationPanel(tab: .Home)
            changeSelectedTab(tab: .Home)
        }
    }
    
    func changeSelectedTab(tab: NavigationTabs){
        tabHome.image = UIImage(named: "Home_unSelected")
        tabStats.image = UIImage(named: "Stats_unSelected")
        tabMe.image = UIImage(named: "Me_unSelected")
        switch tab {
        case .Home:
            tabHome.image = UIImage(named: "Home_selected")
        case .Stats:
            tabStats.image = UIImage(named: "Stats_selected")
        case .Me:
            tabMe.image = UIImage(named: "Me_selected")
        }
    }
}

enum NavigationTabs {
    case Home, Stats, Me
}
