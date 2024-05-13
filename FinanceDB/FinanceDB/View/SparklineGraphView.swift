//
//  SparklineGraphView.swift
//  FinanceDB
//
//  Created by Cemalhan Alptekin on 13.05.2024.
//

import UIKit

class SparklineGraphView: UIView {
    
    var sparklineValues: [Float] = []
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            
            guard !sparklineValues.isEmpty else {
                return
            }
            
            let path = UIBezierPath()
            path.lineWidth = 2.0
            
            let startPoint = CGPoint(x: 0, y: calculateYPosition(for: sparklineValues[0]))
            path.move(to: startPoint)
            
            for i in 1..<sparklineValues.count {
                let nextPoint = CGPoint(x: CGFloat(i) * rect.width / CGFloat(sparklineValues.count - 1),
                                        y: calculateYPosition(for: sparklineValues[i]))
                path.addLine(to: nextPoint)
            }
            
            UIColor.blue.setStroke()
            path.stroke()
        }
        
        private func calculateYPosition(for value: Float) -> CGFloat {
            // Calculate the y-position of the point based on the value
            // Adjust this calculation based on your specific requirements
            let maxValue = sparklineValues.max() ?? 1.0
            let normalizedValue = CGFloat(value) / CGFloat(maxValue)
            return bounds.height * (1.0 - normalizedValue)
        }

}
