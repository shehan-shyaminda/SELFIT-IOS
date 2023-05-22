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
    let Stats = StatsViewController()
//    let Me = MeViewController()
    
    let containerUIView: UIView = {
        let containterStack = UIView()
        containterStack.backgroundColor = UIColor(named: "Background")
        return containterStack
    }()
    
    let botmNavUIView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.backgroundColor = .gray
        containterStack.axis = .horizontal
        containterStack.distribution = .equalSpacing
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initiateNavigationPanel(tab: .Home)
        
        botmNavUIView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        botmNavUIView.isLayoutMarginsRelativeArrangement = true
        containerUIView.bringSubviewToFront(botmNavUIView)
        botmNavUIView.layer.cornerRadius = 15
        botmNavUIView.layer.shadowColor = UIColor.black.cgColor
        botmNavUIView.layer.shadowOffset = CGSize(width: 0, height: 2)
        botmNavUIView.layer.shadowOpacity = 0.4
        botmNavUIView.layer.shadowRadius = 4
        
        botmNavUIView.addArrangedSubview(tabHome)
        botmNavUIView.addArrangedSubview(tabStats)
//        botmNavUIView.addArrangedSubview(tabMe)
        containerUIView.addSubview(botmNavUIView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        let tapNavGestureHome = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
        let tapNavGestureStats = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
//        let tapNavGestureMe = UITapGestureRecognizer(target: self, action: #selector(handleNavigationPanel(_:)))
        tabHome.addGestureRecognizer(tapNavGestureHome)
        tabStats.addGestureRecognizer(tapNavGestureStats)
//        tabMe.addGestureRecognizer(tapNavGestureMe)
    }
    
    func setupSnaps() {
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        botmNavUIView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(40)
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
        
//        tabMe.snp.makeConstraints{ make in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//        }
    }
    
    func initiateNavigationPanel(tab: NavigationTabs){
        removeAllSubviewsExcept(from: containerUIView, except: botmNavUIView)
        changeSelectedTab(tab: .Home)
        switch tab {
        case .Home:
            containerUIView.addSubview(Home.view)
            addChild(Home)
            Home.didMove(toParent: self)
            Home.view.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50)
                make.leading.trailing.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().inset(125)
            }
        case .Stats:
            containerUIView.addSubview(Stats.view)
            addChild(Stats)
            Stats.didMove(toParent: self)
            Stats.view.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(50)
                make.leading.trailing.equalToSuperview().inset(15)
                make.bottom.equalToSuperview().inset(125)
            }
            
//        case .Me:
//            containerUIView.addSubview(Me.view)
//            addChild(Me)
//            Me.didMove(toParent: self)
//            Me.view.snp.makeConstraints { make in
//                make.top.equalToSuperview().inset(50)
//                make.leading.trailing.equalToSuperview().inset(15)
//                make.bottom.equalToSuperview().inset(125)
//            }
        }
        containerUIView.bringSubviewToFront(botmNavUIView)
    }
    
    @objc func handleNavigationPanel(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        switch imageView.tag {
        case 0:
            initiateNavigationPanel(tab: .Home)
            changeSelectedTab(tab: .Home)
        case 1:
            initiateNavigationPanel(tab: .Stats)
            changeSelectedTab(tab: .Stats)
//        case 2:
//            initiateNavigationPanel(tab: .Me)
//            changeSelectedTab(tab: .Me)
        default:
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
//        case .Me:
//            tabMe.image = UIImage(named: "Me_selected")
        }
    }
}

enum NavigationTabs {
    case Home, Stats
//         Me
}
