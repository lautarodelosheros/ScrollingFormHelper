# ScrollingFormHelper

[![Version](https://img.shields.io/cocoapods/v/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)
[![License](https://img.shields.io/cocoapods/l/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)
[![Platform](https://img.shields.io/cocoapods/p/ScrollingFormHelper.svg?style=flat)](https://cocoapods.org/pods/ScrollingFormHelper)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+

## Installation

ScrollingFormHelper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ScrollingFormHelper'
```

## Usage

Initialize an instance of ScrollingFormHelper on the view controller's viewDidLoad method:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollingFormHelper = ScrollingFormHelper(scrollView: scrollView, contentView: stackView, shouldDismissKeyboardOnTap: true)
    setupTextFields()
}
```

Then set the currentTextField attribute on textFieldDidBeginEditing (You need to set the delegate for each one of your text fields):

```swift
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollingFormHelper?.currentTextField = textField
    }
}
```

You can also refer to the example app on this repository.

## Author

lautarodelosheros, lautarodelosheros@gmail.com

## License

ScrollingFormHelper is available under the MIT license. See the LICENSE file for more info.
