# ControlSlider


## Description
The ControlSlider is a custom UIControl for iOS written in Swift 2.0.


![Example 1](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/screen0_s.png)
![Example 2](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/screen1_s.png)
![Example 3](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/screen2_s.png)


Features:

* vertical Slider 
* @IBDesignable/@Inspectable for direct use within Interface Builder
* use together with ReactiveCocoa

License: MIT
Language: Swift 2

## Requirements
- iOS 8.0+
- Xcode 7

## Installation

The easiest way is to use [CocoaPods](http://cocoapods.org) for using ControlSlider

```ruby
use_frameworks!
pod 'ControlSlider', :git =>  'https://github.com/msedd/ControlSlider.git'
```

## Usage
* add a UIView to your controller in the storyboard 
![add View](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/integration0.png)

* select as Class and Modul *ControlSlider*
![select class](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/integration1.png)

* you can adjust the color of each part from the Slider
![Customize the color](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/adjust.png)

* add the UIView as @IBOutlet to your Controller class
![add Outlet](https://raw.githubusercontent.com/msedd/ControlSlider/master/screens/integration2.png)

* use ControlSlider together with [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
```swift
override func viewDidLoad() {
	super.viewDidLoad()
    ...
	self.dimmer1.rac_valuesForKeyPath("value", observer: self).subscribeNext { (newVal:AnyObject!) -> Void in
    	let value = newVal as! Float
        let intValue:UInt8 = UInt8(value)
        self.data[0]=intValue
		BluetoothController.sharedInstance.send(self.data)
	}
	self.dimmer2.rac_valuesForKeyPath ...
	...
}
```
## License
Copyright 2016 Marko Seifert
ControlSlider is available under the Apache2 License. See the LICENSE file for more info.