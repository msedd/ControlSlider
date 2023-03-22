//
//  DimSlider.swift
//  ControlSlider.h
//
//  Created by Marko Seifert on 21.12.15.
//
//  Copyright © 2015 Marko Seifert.
//  Licensed under the Apache License, Version 2.0 (the "License")

import UIKit

@IBDesignable open class ControlSlider: UIControl {
    
    
    @IBInspectable open var activeFillColor: UIColor = UIColor(red: 0.232, green: 0.653, blue: 0.999, alpha: 1.000)
    @IBInspectable open var textForeground: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable open var  buttonColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.640)
    @IBInspectable open var  buttonStrokeColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable open var  bgBarColor: UIColor = UIColor(red: 0.1647, green: 0.1647, blue: 0.1647, alpha: 1.0)
    @IBInspectable open var  bgColor: UIColor = UIColor(red: 0.1255, green: 0.1255, blue: 0.1255, alpha: 1.0)
    @IBInspectable open var  maxValue:CGFloat = 255
    @IBInspectable open var  minValue:CGFloat = 0
    @IBInspectable open var  relative:Bool = false
    
    fileprivate var offset: Float = 0
    fileprivate var _value: Float = 0
    
    dynamic open var value: Float {
        get {
            return _value
        }
    }
    
    var size:CGRect {
        get {
            let bounds = self.bounds
            let offset: CGFloat = 30.0
            return CGRect(x: bounds.origin.x, y: (bounds.origin.y+offset/2), width: bounds.size.width,height: (bounds.size.height - offset))
        }
    }
    var viewSize:CGRect {
        get {
            let bounds = self.bounds
            return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width,height: bounds.size.height)
        }
    }
    
    var length:CGFloat{
        get {
            return CGFloat(value) * (size.height)/maxValue
        }
    }
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
    
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    open func setValue(value: Float) {
        let mav = Float(maxValue)
        let miv = Float(minValue)
        if value > mav {
            _value = mav
        } else if value < miv {
            _value = miv
        } else {
            _value = value
        }
    }
    
    fileprivate func setValueInternal(value: Float) {
        setValue(value: value)
        sendActions(for: .valueChanged)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, relative {
            let loc = touch.location(in: self)
            let v = (size.height-loc.y) / size.height * maxValue
            offset = value - Float(v)
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        offset = 0
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let loc = touch.location(in: self)
            
            
            let v = ((size.height-loc.y) / size.height * maxValue) + CGFloat(offset)
            //print("dimmer val: \(v)")
            if(v < 0) {
                setValueInternal(value: 0)
            } else if (v>maxValue) {
                setValueInternal(value: Float(maxValue))
            } else {
                setValueInternal(value: Float(v))
            }
            self.setNeedsDisplay()
            
        }
    }
    
    override open func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.clear(rect)
        drawBackground()
        drawActiveBar()
        drawButton()
    }
    
    func drawButton(){
        
        let buttonPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x, y: size.height-length, width: size.width, height: 30), cornerRadius: 6)
        buttonColor.setFill()
        buttonPath.fill()
        buttonStrokeColor.setStroke()
        buttonPath.lineWidth = 1
        buttonPath.stroke()
        
        let labelRect = CGRect(x: size.origin.x, y: size.height-length, width: size.width, height: 30)
        let labelStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        labelStyle.alignment = .center
        let labelFontAttributes =
            
            [//NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18),
                NSAttributedString.Key.foregroundColor: textForeground,
                NSAttributedString.Key.paragraphStyle: labelStyle]
        
        let intValue:Int = Int(value)
        NSString(string: "\(intValue)").draw(in: labelRect, withAttributes:labelFontAttributes)
        

    }
    
    func drawActiveBar(){
        
        let bgBarPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x+4, y: size.height-length+15, width: size.width-8, height: length), cornerRadius: 4)
        activeFillColor.setFill()
        bgBarPath.fill()
    }
    
    func drawBackground(){
        
        let bgPath = UIBezierPath(rect: viewSize)
        bgColor.setFill()
        bgPath.fill();
        
        let bgBarPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x+4, y: size.origin.y, width: size.width-8, height: size.height), cornerRadius: 4)
        bgBarColor.setFill()
        bgBarPath.fill()
        
    }
}
