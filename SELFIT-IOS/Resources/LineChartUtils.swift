//
//  LineChartUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-20.
//

import Foundation
import UIKit

class LineChartView: UIView {
    var dataPoints: [CGFloat] = [] {
        didSet {
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        guard !dataPoints.isEmpty else {
            return
        }

        let maxValue = dataPoints.max() ?? 0
        let path = UIBezierPath()
        let spacing = bounds.width / CGFloat(dataPoints.count - 1)

        for (index, dataPoint) in dataPoints.enumerated() {
            let x = CGFloat(index) * spacing
            let y = bounds.height - (dataPoint / maxValue) * bounds.height

            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }

        UIColor.blue.setStroke()
        path.stroke()
    }
}
