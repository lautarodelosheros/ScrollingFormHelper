//
//  ScrollingFormHelper.swift
//  ScrollingFormHelper
//
//  Created by Lautaro de los Heros on 19/04/2021.
//

import Foundation
import UIKit

public class ScrollingFormHelper {
    
    // Set the current text field on textFieldDidBeginEditing on the UITextFieldDelegate
    public var currentTextField: UITextField? {
        didSet {
            guard let currentTextField = currentTextField else { return }
            scrollTo(textField: currentTextField)
        }
    }
    
    // The scroll view that you want to manage
    private var scrollView: UIScrollView
    // The child view of the scroll view that is the container
    private var contentView: UIView
    
    private var contentViewLastItemMaxY: CGFloat = 0.0
    private var keyboardHeight: CGFloat = 0.0
    
    public init(scrollView: UIScrollView, contentView: UIView, shouldDismissKeyboardOnTap: Bool = false) {
        self.scrollView = scrollView
        self.contentView = contentView
        registerForKeyboardNotifications()
        
        if shouldDismissKeyboardOnTap {
            let tap = UITapGestureRecognizer(target: contentView, action: #selector(UIView.endEditing))
            tap.cancelsTouchesInView = false
            contentView.addGestureRecognizer(tap)
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardChangeFrame(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardDidHide, object: nil)
    }
    
    @objc private func onKeyboardChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect: CGRect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        keyboardHeight = keyboardRect.size.height
        
        if let currentTextField = currentTextField {
            scrollTo(textField: currentTextField)
        }
    }
    
    @objc private func onKeyboardDisappear(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentInset = UIEdgeInsets.zero
            self.scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
    
    private func scrollTo(textField: UITextField) {
        guard let lastItem = contentView.subviews.last else {
            return
        }
        let keyboardHeightFromTop = scrollView.frame.height - keyboardHeight
        
        contentViewLastItemMaxY = lastItem.frame.origin.y + lastItem.frame.height
        
        var contentInset = min(keyboardHeight, contentViewLastItemMaxY - keyboardHeightFromTop)
        if contentInset < 0 {
            contentInset = 0
        }
        
        var scrollPosition = textField.convert(textField.bounds.origin, to: scrollView).y - keyboardHeightFromTop + offsetAdjustment()
        if scrollPosition < 0 {
            scrollPosition = 0
        }
        
        let newInsets = UIEdgeInsets(top: self.scrollView.contentInset.top, left: self.scrollView.contentInset.left, bottom: contentInset, right: self.scrollView.contentInset.right)
        DispatchQueue.main.async {
            self.scrollView.contentInset = newInsets
            self.scrollView.scrollIndicatorInsets = newInsets
            self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollPosition), animated: true)
        }
    }
    
    private func offsetAdjustment() -> CGFloat {
        let offsetForNotchDevices: CGFloat = 10
        let offsetForNonNotchDevices: CGFloat = 44
        guard #available(iOS 11.0, *),
              let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first
        else {
            return offsetForNonNotchDevices
        }
        if UIDevice.current.orientation.isPortrait {
            if window.safeAreaInsets.top >= 44 {
                return offsetForNotchDevices
            }
            return offsetForNonNotchDevices
        } else {
            if window.safeAreaInsets.left > 0 || window.safeAreaInsets.right > 0 {
                return offsetForNotchDevices
            }
            return offsetForNonNotchDevices
        }
    }
}
