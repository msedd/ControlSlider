//
//  DimSlider.swift
//  ControlSlider.h
//
//  Created by Marko Seifert on 21.12.15.
//
//  Copyright © 2015 Marko Seifert.
//  Licensed under the Apache License, Version 2.0 (the "License")

import UIKit

@IBDesignable open class ControlVSlider: UIControl {
    
    
    @IBInspectable open var activeFillColor: UIColor = UIColor(red: 0.232, green: 0.653, blue: 0.999, alpha: 1.000)
    @IBInspectable open var textForeground: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable open var  buttonColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.640)
    @IBInspectable open var  buttonStrokeColor: UIColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
    @IBInspectable open var  bgBarColor: UIColor = UIColor(red: 0.1647, green: 0.1647, blue: 0.1647, alpha: 1.0)
    @IBInspectable open var  bgColor: UIColor = UIColor(red: 0.1255, green: 0.1255, blue: 0.1255, alpha: 1.0)
    @IBInspectable open var  maxValue:CGFloat = 255
    open var defaultValue:Float = 0
    open var showLable:Bool = true
    fileprivate var _value: Float = 0
    
    dynamic open var value: Float {
        get {
            return _value
        }
    }
    var size:CGRect {
        get {
            let bounds = self.bounds
            let offset: CGFloat = 50.0
            
            return CGRect(x: bounds.origin.x+offset/2, y: bounds.origin.y, width: bounds.size.width-offset,height: bounds.size.height)
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
            return CGFloat(value) * (size.width)/maxValue
        }
    }
    
    override public init(frame: CGRect) {
        
        super.init(frame: frame)
        registerGesture()
    }

    required public init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        registerGesture()
    }
    
    fileprivate func registerGesture() {
        let doubleTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetToDefault))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }
    @objc func resetToDefault(){
        setValueInternal(value: defaultValue)
        self.setNeedsDisplay()
    }
    
    open func setValue(value: Float) {
        _value = value
    }
    
    fileprivate func setValueInternal(value: Float) {
        _value = value
        sendActions(for: .valueChanged)
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let loc = touch.location(in: self)
            
            
            let v = (loc.x) / size.width * maxValue
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
        
        let buttonPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x+length-20, y: size.origin.y, width: 40, height: size.height), cornerRadius: 6)
        buttonColor.setFill()
        buttonPath.fill()
        buttonStrokeColor.setStroke()
        buttonPath.lineWidth = 1
        buttonPath.stroke()
        if showLable {
            let labelRect = CGRect(x: size.origin.x+length-20, y: size.height-30 , width: 40, height: 30)
            let labelStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            labelStyle.alignment = .center
            let labelFontAttributes =
                
                [//NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 18),
                    NSAttributedString.Key.foregroundColor: textForeground,
                    NSAttributedString.Key.paragraphStyle: labelStyle]
            
            let intValue:Int = Int(value)
            NSString(string: "\(intValue)").draw(in: labelRect, withAttributes:labelFontAttributes)
        }

    }
    
    func drawActiveBar(){
        
       let bgBarPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x, y: size.origin.y+4, width: length, height: size.height-8), cornerRadius: 4)
       
        activeFillColor.setFill()
        bgBarPath.fill()
    }
    
    func drawBackground(){
        
        let bgPath = UIBezierPath(rect: viewSize)
        bgColor.setFill()
        bgPath.fill();
        
       let bgBarPath = UIBezierPath(roundedRect: CGRect(x: size.origin.x, y: size.origin.y+4, width: size.width, height: size.height-8), cornerRadius: 4)
        bgBarColor.setFill()
        bgBarPath.fill()
        
    }
}
