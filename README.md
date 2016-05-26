# MZPopView

[![CI Status](http://img.shields.io/travis/monzy613/MZPopView.svg?style=flat)](https://travis-ci.org/monzy613/MZPopView)
[![Version](https://img.shields.io/cocoapods/v/MZPopView.svg?style=flat)](http://cocoapods.org/pods/MZPopView)
[![License](https://img.shields.io/cocoapods/l/MZPopView.svg?style=flat)](http://cocoapods.org/pods/MZPopView)
[![Platform](https://img.shields.io/cocoapods/p/MZPopView.svg?style=flat)](http://cocoapods.org/pods/MZPopView)

## snapshots
![img](http://o7b20it1b.bkt.clouddn.com/popView.png)
![img](http://o7b20it1b.bkt.clouddn.com/popLabel.png)
![img](http://o7b20it1b.bkt.clouddn.com/popButtonGroup.png)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MZPopView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MZPopView"
```

## Quick use
###Objc
```objc
[popView popLeftFromPoint:popCenter];
[popView popRightFromPoint:popCenter];
[popView popUpFromPoint:popCenter];
[popView popDownFromPoint:popCenter];
```

###Swift
```swift
popView.popLeftFromPoint(popCenter)
popView.popRightFromPoint(popCenter)
popView.popUpFromPoint(popCenter)
popView.popDownFromPoint(popCenter)
```

## Author

monzy613, monzy613@gmail.com

## License

MZPopView is available under the MIT license. See the LICENSE file for more info.
