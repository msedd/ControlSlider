//
//  DimSlider.swift
//  ControlSlider.h
//
//  Created by Marko Seifert on 21.12.15.
//
//  Copyright © 2015 Marko Seifert.
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

import UIKit

@IBDesignable public class ControlSlider: UIControl {

    
    @IBInspectable var activeFillColor: UIColor = UIColor(red: 0.232, green: 0.653, blue: 0.999, alpha: 1.000)
    @IBInspectable var textForeground: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable var  buttonColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.640)
    @IBInspectable var  buttonStrokeColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable var  bgBarColor: UIColor = UIColor(red: 0.1647, green: 0.1647, blue: 0.1647, alpha: 1.0)
    @IBInspectable var  bgColor: UIColor = UIColor(red: 0.1255, green: 0.1255, blue: 0.1255, alpha: 1.0)
    @IBInspectable var  maxValue:CGFloat = 255

    private var _value: Float = 0
    dynamic public var value: Float {
        get {
            return _value
        }
        set (newValue) {
            _value = newValue
            self.sendActionsForControlEvents(.ValueChanged)
            
        }
    }
    
    var size:CGRect {
        get {
            let bounds = self.bounds
            let offset: CGFloat = 30.0
            return CGRectMake(bounds.origin.x, (bounds.origin.y+offset/2), bounds.size.width,(bounds.size.height - offset))
        }
    }
    var viewSize:CGRect {
        get {
            let bounds = self.bounds
            return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width,bounds.size.height)
        }
    }
    
    var length:CGFloat{
        get {
            return CGFloat(value) * (size.height)/maxValue
        }
    }
    
    override init(frame: CGRect) {
       
        super.init(frame: frame)

    }
    
    required public init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
    }

    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

    }
    override public func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if let touch = touches.first {
            let loc = touch.locationInView(self)
            
            
            let v = (size.height-loc.y) / size.height*maxValue
            if(v < 0){
                value = 0
            }else if (v>maxValue){
                value = Float(maxValue)
            }else{
                value = Float(v)
            }
            self.setNeedsDisplay()
            
        
            //NSLog("\(value)=\(size.height)-\(loc.y)/\(size.height)*maxValue\n")
        }
    }
    
    override public func drawRect(rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        CGContextClearRect(ctx,rect)
        drawBackground()
        drawActiveBar()
        drawButton()
    }
    
    func drawButton(){
        
        let buttonPath = UIBezierPath(roundedRect: CGRectMake(size.origin.x, size.height-length, size.width, 30), cornerRadius: 6)
        buttonColor.setFill()
        buttonPath.fill()
        buttonStrokeColor.setStroke()
        buttonPath.lineWidth = 1
        buttonPath.stroke()
        
        let labelRect = CGRectMake(size.origin.x, size.height-length, size.width, 30)
        let labelStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        labelStyle.alignment = .Center
        
        let labelFontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 18)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: labelStyle]
        let intValue:Int = Int(value)
        NSString(string: "\(intValue)").drawInRect(labelRect, withAttributes: labelFontAttributes)
    }
    
    func drawActiveBar(){
        
        let bgBarPath = UIBezierPath(roundedRect: CGRectMake(size.origin.x+4, size.height-length+15, size.width-8, length), cornerRadius: 4)
        activeFillColor.setFill()
        bgBarPath.fill()
    }
    
    func drawBackground(){
        
        let bgPath = UIBezierPath(rect: viewSize)
        bgColor.setFill()
        bgPath.fill();
        
        let bgBarPath = UIBezierPath(roundedRect: CGRectMake(size.origin.x+4, size.origin.y, size.width-8, size.height), cornerRadius: 4)
        bgBarColor.setFill()
        bgBarPath.fill()
        
    }
}
