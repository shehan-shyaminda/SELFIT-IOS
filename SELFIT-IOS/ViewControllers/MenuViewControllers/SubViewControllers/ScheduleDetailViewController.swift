//
//  ScheduleDetailViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import UIKit

class ScheduleDetailViewController: UIViewController {
    let networkManager = NetworkManager()
    let schedule: Schedules
    var exercisesList: [Exercise] = []
    var scheduleName: String
    
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
    
    let hintUIImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(imageLiteralResourceName: "Frame_5")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleUIStack: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .fill
        containterStack.alignment = .leading
        containterStack.spacing = 10
        return containterStack
    }()
    
    let exerciseTable: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.backgroundView = nil
        return table
    }()
    
    let exerciseNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "IntegralCF-Bold", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "14 Day Challenge Weight Loose"
        label.textColor = .white
        return label
    }()
    
    required init(schedules: Schedules, scheduleName: String) {
        self.schedule = schedules
        self.scheduleName = scheduleName
        super.init(nibName: nil, bundle: nil)                                        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        exerciseTable.dataSource = self
        exerciseTable.delegate = self
        exerciseTable.register(ExerciseTableViewCell.self, forCellReuseIdentifier: "ExerciseTableViewCell")
        
        exerciseNameLabel.text = scheduleName
        
        titleUIStack.addArrangedSubview(exerciseNameLabel)
        hintUIImage.addSubview(titleUIStack)
        containerStackView.addArrangedSubview(hintUIImage)
        containerStackView.addArrangedSubview(exerciseTable)
        containerUIView.addSubview(containerStackView)
        view.addSubview(containerUIView)
        
        setupSnaps()
    }
    
    func setupSnaps() {
        hintUIImage.snp.makeConstraints{(make) -> Void in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(200)
        }
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        containerUIView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleUIStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(40)
        }
        
        exerciseTable.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.75)
        }
        
    }
    
    func getData() {
        self.exercisesList.removeAll()
        let data = ReqScheduleExercises(scheduleList: schedule.scheduleList)
        guard let jsonData = try? JSONEncoder().encode(data) else {
            print("Failed to encode JSON data")
            return
        }
        networkManager.performNetworkCall(NetworkManager.getExerciseList_url, httpMethod: .post, headers: ["authorization":"Bearer \(UserDefaults.standard.string(forKey: "accessToken")!)"], httpBody: jsonData) { [self] (result: Result<ResScheduleExecises, Error>) in
            switch result {
            case .success(let res):
                if res.status {
                    DispatchQueue.main.async {
                        if res.status {
                            self.exercisesList.append(contentsOf: res.data)
                            self.exerciseTable.reloadData()
                        }
                    }
                } else {
                    print("Oops! Something went wrong.")
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension ScheduleDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exercisesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseTableViewCell", for: indexPath) as! ExerciseTableViewCell
        
        loadImage(from: URL(string: exercisesList[indexPath.row].exerciseBannerURL)!, into: cell.hintUIImage)
        cell.exerciseNameLabel.text = "\(exercisesList[indexPath.row].exerciseName)  ( \(exercisesList[indexPath.row].exerciseDuration) mins)"
        cell.focusedArea.text = "Focused Area: \(getFocusedArea(exercisesList[indexPath.row].focusedArea))"
        cell.focusedCalories.text = "Calorie Burns: \(exercisesList[indexPath.row].exerciseCalories) calories"
        cell.userType.text = "User Type: \(getUserType(exercisesList[indexPath.row].userType))"
        cell.genderType.text = "Focused Gender: \(getGender(exercisesList[indexPath.row].exerciseGender))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
