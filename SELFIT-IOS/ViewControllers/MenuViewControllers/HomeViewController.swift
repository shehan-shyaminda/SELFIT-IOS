//
//  HomeViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-15.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    let networkManager = NetworkManager()
    var schedules: [Schedules] = []
    
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
        containterStack.alignment = .leading
        return containterStack
    }()
    
    let hintLabel: UILabel = {
        let label = UILabel()
        label.text = " \" Nothing will work,  unless you do \" "
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(named: "Primary_Orange")
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello Rookie,"
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 24)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let scheduleTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 16)
        label.numberOfLines = 1
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let scheduleTable: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 1, width: 2, height: 2-1))
        table.backgroundColor = UIColor.clear
        table.backgroundView = nil
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduleTable.dataSource = self
        scheduleTable.delegate = self
        getData()
        
        scheduleTable.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(hintLabel)
        containerStackView.addArrangedSubview(titleStackView)
        containerStackView.addArrangedSubview(scheduleTitleLabel)
        containerStackView.addArrangedSubview(scheduleTable)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
        
        
        let userType = getUserType(UserDefaults.standard.integer(forKey: "userType"))
        let planString = "Workout Plans  ( \(userType) )  Level"
        let attributedString = NSMutableAttributedString(string: planString)
        if let range = planString.range(of: userType) {
            attributedString.addAttribute(.foregroundColor, value: UIColor(named: "Primary_Green")!, range: NSRange(range, in: planString))
            attributedString.addAttribute(.font, value: UIFont.init(name: "IntegralCF-Regular", size: 16)!, range: NSRange(range, in: planString))
        }
        scheduleTitleLabel.attributedText = attributedString
    }
    
    func getData() {
        print("calling get data")
        AlertUtils.startAnimate(in: self, animationType: .ballTrianglePath)
        networkManager.performNetworkCall(NetworkManager.getSchedule_url, httpMethod: .get, headers: ["authorization":"Bearer \(UserDefaults.standard.string(forKey: "accessToken")!)"]) { [self] (result: Result<ResScheduleData, Error>) in
            switch result {
            case .success(let res):
                if res.status {
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        self.schedules.removeAll()
                        for schedule in res.data {
                            self.schedules.append(schedule)
                        }
                        self.scheduleTable.reloadData()
                    }
                } else {
                    DispatchQueue.main.async {
                        AlertUtils.dismissAnimate()
                        let snackbar = SnackbarView(title: "Oops! Please check your credentials.", duration: 3.0)
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
    
    @objc func handleNavigationPanel(_ sender: UITapGestureRecognizer) {
        navigateToViewController(GenderViewController(), from: self.navigationController)
    }
    
    func setupSnaps() {
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleStackView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        scheduleTitleLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        scheduleTable.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }

        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerUIView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(100)
        }
    }
    
    @objc func nextTapped(){
        navigateToViewController(HeightViewController(), from: self.navigationController)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        loadImage(from: URL(string: schedules[indexPath.row].scheduleBannerURL)!, into: cell.hintUIImage)
        cell.hintLabel.text = schedules[indexPath.row].scheduleName
        cell.titleLabel.text = getExercisesType(schedules[indexPath.row].scheduleType)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ScheduleDetailViewController(schedules: schedules[indexPath.row], scheduleName: schedules[indexPath.row].scheduleName)
        navigateToViewController(vc, from: self.navigationController)
    }
}
