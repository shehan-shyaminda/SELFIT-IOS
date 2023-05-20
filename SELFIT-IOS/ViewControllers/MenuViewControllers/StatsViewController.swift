//
//  StatsViewController.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-20.
//

import UIKit
import HealthKit
import Charts

class StatsViewController: UIViewController {
    let healthStore = HKHealthStore()
    let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
    
    let noDataStackView: UIStackView = {
        let containterStack = UIStackView()
        containterStack.axis = .vertical
        containterStack.distribution = .equalSpacing
        containterStack.alignment = .center
        containterStack.spacing = 10
        return containterStack
    }()
    
    let noDataLabel: UILabel = {
        let label = UILabel()
        label.text = "No step count data available"
        label.font = UIFont.init(name: "IntegralCF-Regular", size: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let noDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tag = 0
        imageView.image = UIImage(imageLiteralResourceName: "ic_stepData")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let chartView: LineChartView = {
        let chartView = LineChartView()
        return chartView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        fetchStepCountData()
    }
    
    func requestAuthorization() {
        let stepCountType = HKObjectType.quantityType(forIdentifier: .stepCount)!
        let typesToShare: Set<HKSampleType> = []
        let typesToRead: Set<HKObjectType> = [stepCountType]
        
        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            if success {
                self.fetchStepCountData()
            } else {
                if let error = error {
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func fetchStepCountData() {
        self.chartView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(self.chartView)
        let calendar = Calendar.current
        let now = Date()
        let startOfDay = calendar.startOfDay(for: now)
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepCountType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (query, result, error) in
            if let error = error {
                print("Failed to fetch step count data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.noDataStackView.addArrangedSubview(self.noDataImageView)
                    self.noDataStackView.addArrangedSubview(self.noDataLabel)
                    self.view.addSubview(self.noDataStackView)
                    
                    self.noDataStackView.snp.makeConstraints { make in
                        make.width.equalToSuperview()
                        make.height.equalToSuperview().dividedBy(2.5)
                        make.centerY.equalToSuperview()
                    }
                }
                return
            }
            
            guard let result = result, let sum = result.sumQuantity() else {
                print("No step count data available")
                DispatchQueue.main.async {
                    self.noDataStackView.addArrangedSubview(self.noDataImageView)
                    self.noDataStackView.addArrangedSubview(self.noDataLabel)
                    self.view.addSubview(self.noDataStackView)
                    
                    self.noDataStackView.snp.makeConstraints { make in
                        make.width.equalToSuperview()
                        make.height.equalToSuperview().dividedBy(2.5)
                        make.centerY.equalToSuperview()
                    }
                }
                return
            }
            
            let stepCount = sum.doubleValue(for: HKUnit.count())
            print("Step count: \(stepCount)")
            
            DispatchQueue.main.async {
                self.chartView.data = nil
                var dataEntries: [ChartDataEntry] = []
                let dataEntry = ChartDataEntry(x: 0, y: stepCount)
                dataEntries.append(dataEntry)
                let dataSet = LineChartDataSet(entries: dataEntries, label: "Step Count")

                dataSet.colors = [.blue]
                dataSet.circleColors = [.blue]
                dataSet.circleHoleColor = .blue
                dataSet.lineWidth = 2.0
                dataSet.drawCircleHoleEnabled = true
                let data = LineChartData(dataSet: dataSet)
                self.chartView.data = data
            }
        }
        
        healthStore.execute(query)
    }
}
