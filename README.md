# ScrollingFormHelper

[![Version](https://img.shields.io/cocoapods/v/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)
[![License](https://img.shields.io/cocoapods/l/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)
[![Platform](https://img.shields.io/cocoapods/p/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+

## Installation

ScrollingFormHelper is available through Swift Package Manager, simply add it as a new dependency.

ScrollingFormHelper is also available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ScrollingFormHelper'
```

## Usage

Set the class of your UIScrollView to KeyboardAwareScrollView. Then, whenever you want to focus on a view that presents the keyboard, set the currentView attribute of KeyboardAwareScrollView to that view.

For example, let's say you have a UITextField inside a KeyboardAwareScrollView:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    textField.delegate = self
}
```

Then set the currentView attribute on textFieldDidBeginEditing:

```swift
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        keyboardAwareScrollView.currentView = textField
    }
}
```

You can also refer to the example app on this repository.

## Author

lautarodelosheros, lautarodelosheros@gmail.com

## License

ScrollingFormHelper is available under the MIT license. See the LICENSE file for more info.
