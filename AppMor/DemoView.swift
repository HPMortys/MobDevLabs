//
//  NewView.swift
//  AppMor
//
//  Created by Den Mor on 20.02.2021.
//

import UIKit

enum Shape {
    case graph
    case chart
}


class DemoView: UIView {

    var currentShape: Shape?
    
    
    override func draw(_ rect: CGRect) {
        switch currentShape {
        case .chart:
            drawChart()
        case .graph:
            drawGraph()
        default:
            drawGraph()
        }
    }
    
    
    private func drawChart(){
        let thickness: CGFloat = 65
        let data = [10, 20, 25, 5, 40]
        let colors = [UIColor.yellow, UIColor.green, UIColor.blue, UIColor.red, UIColor.cyan]

        let center = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        let radius = min(bounds.size.width, bounds.size.height) / 2.0
        let total: CGFloat = data.reduce(0) { $0 + CGFloat($1) } / (2 * .pi)
        var startAngle = CGFloat.pi

        UIColor.white.setStroke()

        for (color, value) in zip(colors, data) {
            let endAngle = startAngle + CGFloat(value) / total

            let slice = UIBezierPath()
            slice.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            slice.addArc(withCenter: center, radius: radius - thickness, startAngle: endAngle, endAngle: startAngle, clockwise: false)
            slice.close()

            color.setFill()
            slice.fill()
            
            startAngle = endAngle
    }
    }
    private func drawGraph(){
    
        let startPointY = CGPoint(x: bounds.size.width / 2 , y: bounds.size.height)
        let endPointY = CGPoint(x: bounds.size.width / 2 , y: 0 )
        let startPointX = CGPoint(x: 0 , y: bounds.size.height / 2 )
        let endPointX = CGPoint(x: bounds.size.width , y: bounds.size.height / 2)
        
      
        let arrow = UIBezierPath()
        // Y axis
        arrow.move(to: startPointY)
        arrow.addLine(to: endPointY)
        arrow.addLine(to: CGPoint(x: bounds.size.width / 2 - 8 , y:  8))
        arrow.move(to: endPointY)
        arrow.addLine(to: CGPoint(x: bounds.size.width / 2 + 8 , y:  8))
        // X axis
        arrow.move(to: startPointX)
        arrow.addLine(to: endPointX)
        arrow.addLine(to: CGPoint(x: bounds.size.width - 8 , y: bounds.size.height / 2 - 8))
        arrow.move(to: endPointX)
        arrow.addLine(to: CGPoint(x: bounds.size.width - 8 , y: bounds.size.height / 2 + 8))
        
        // lines
        arrow.move(to: CGPoint(x: 150, y: 120))
        arrow.addLine(to: CGPoint(x: 150, y: 128))
        arrow.addLine(to: CGPoint(x: 150, y: 112))
        arrow.move(to: CGPoint(x: 120, y: 90))
        arrow.addLine(to: CGPoint(x: 112, y: 90))
        arrow.addLine(to: CGPoint(x: 128, y: 90))
        
        var x: CGFloat?
        var y: CGFloat?
        
        x = 0.01
        y = log(x!)
        //graph
        let graph = UIBezierPath()
        graph.move(to: CGPoint(x: x!*30+120, y: y!*30+120))
        for i in stride(from: 0.02, to: 3.99, by: 0.01){
            x = CGFloat(i)
            y = -log(x!)
            if (x==3.98){
                graph.move(to: CGPoint(x: 0, y: 0))
                break
            }
            graph.addLine(to: CGPoint(x: x!*30+120, y: y!*30+120))
        }
        graph.close()
        graph.lineWidth = 1.5
        UIColor.blue.setStroke()
        graph.stroke()
        
        
        arrow.close()
        arrow.lineWidth = 1.0
        UIColor.black.setStroke()
        arrow.stroke()
    }
    
    
    func drawShape(selectedShape: Shape){
        currentShape = selectedShape
        setNeedsDisplay()
    }
}
