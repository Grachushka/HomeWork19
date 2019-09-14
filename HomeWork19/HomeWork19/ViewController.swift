//
//  ViewController.swift
//  HomeWork19
//
//  Created by Pavel Procenko on 12/09/2019.
//  Copyright © 2019 Pavel Procenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private var draggingView: UIView?
    private var offset: CGPoint?
    private var squars = [UIView]()
    private var points: CGPoint?
    private var pointsSecond: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
                view.isMultipleTouchEnabled = true
        
        squars = createAndGetSquars()
       
    }
    
   
    
    private func createAndGetSquars() -> [UIView] {
        
        var arrayOfSquars = [UIView]()
        
        var x = 0
        let y = 150
        
        
        for i in 0..<3 {
            
           
            var width = 100
            var height = 100
            
            if i == 1 {
                
                width -= width/5
                height -= height/5
                x -= 150
                
            }
            let view = UIView()

            view.frame = CGRect(x: x, y: y, width: width, height: height)
            view.backgroundColor = UIColor(
                red: CGFloat.random(in: 0.0..<1.0),
                green: CGFloat.random(in: 0.0..<1.0),
                blue: CGFloat.random(in: 0.0..<1.0),
                alpha: 1
            )
            self.view.addSubview(view)
            arrayOfSquars.append(view)
            x += 150
        }
        
        
        return arrayOfSquars
    }
    
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
             let points = touches.map { $0.location(in: self.view) }
            let point = touches.map { $0.location(in: self.view) }.randomElement()!
            if let view = self.view.hitTest(point, with: event), view == squars[1]
            
            {
               

                draggingView = view
                self.view.bringSubviewToFront(view)
                offset = CGPoint(x: points[0].x - view.center.x, y: points[0].y - view.center.y)
     
            }
            print("Touches begin: \(points)")
            self.points = points[0]
        }
    
        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesMoved(touches, with: event)

            let points = touches.map { $0.location(in: self.view) }
    
            if let view = draggingView {
                let point = points.randomElement()!
                view.center = CGPoint(x: point.x - offset!.x, y: point.y - offset!.y)
            }
    
            print("Touches moved: \(points)")
        }
    
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
    
            endTouches()
            

            let pointsFirstSquar = squars[0].frame
            let pointsSecondSquar =  squars[2].frame
            let pointsIteractionSquar = squars[1].frame
            
            
            if pointsIteractionSquar.minX >= pointsFirstSquar.minX && pointsIteractionSquar.maxX <= pointsFirstSquar.maxX && pointsIteractionSquar.minY >= pointsFirstSquar.minY && pointsIteractionSquar.maxY <= pointsFirstSquar.maxY ||
                
                pointsIteractionSquar.minX >= pointsSecondSquar.minX && pointsIteractionSquar.maxX <= pointsSecondSquar.maxX && pointsIteractionSquar.minY >= pointsSecondSquar.minY && pointsIteractionSquar.maxY <= pointsSecondSquar.maxY  {
                endTouches()
            } else {
                squars[1].frame = CGRect(x: self.points!.x, y: self.points!.y, width: 80, height: 80)
            }
        }
    
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesCancelled(touches, with: event)
    
            endTouches()
            let points = touches.map { $0.location(in: self.view) }
    
            print("Touches cancelled: \(points)")
        }
    
        private func endTouches() {
            
            draggingView = nil
            offset = nil
        }
    
    
    
    
}
