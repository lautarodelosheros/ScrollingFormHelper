//
//  NonScrollingFormHelper.swift
//  ScrollingFormHelper
//
//  Created by Lautaro on 19/04/2021.
//

import Foundation
import UIKit

public class NonScrollingFormHelper {
    
    // The child view of the scroll view that is the container
    private weak var contentView: UIView?
    private let originalViewOriginY: CGFloat
    private let originalViewHeight: CGFloat
    
    private var contentViewLastItemMaxY: CGFloat = 0.0
    private var keyboardHeight: CGFloat = 0.0
    
    public init(contentView: UIView, shouldDismissKeyboardOnTap: Bool = false) {
        self.contentView = contentView
        originalViewHeight = contentView.frame.size.height
        originalViewOriginY = contentView.frame.origin.y
        registerForKeyboardNotifications()
        
        if shouldDismissKeyboardOnTap {
            let tap = UIGestureRecognizer(target: contentView, action: #selector(UIView.endEditing))
            tap.cancelsTouchesInView = false
            contentView.addGestureRecognizer(tap)
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardDisappear(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func onKeyboardChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect: CGRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        keyboardHeight = keyboardRect.size.height
        
        moveViewOnTopOfKeyboard()
    }
    
    @objc private func onKeyboardDisappear(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.contentView?.frame.origin.y = self.originalViewOriginY
        }
    }
    
    public func moveViewOnTopOfKeyboard() {
        UIView.animate(withDuration: 0.2) {
            self.contentView?.frame.origin.y = self.originalViewOriginY - self.keyboardHeight
        }
    }
}
