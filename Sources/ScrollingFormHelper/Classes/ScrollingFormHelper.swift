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
    public weak var currentView: UIView? {
        didSet {
            guard let currentView = currentView else { return }
            scrollTo(view: currentView)
        }
    }

    // Offset that will be considered for the scroll view's bottom offset and the scroll offset to the currentView
    public var customOffset: CGFloat = 0.0
    
    // The scroll view that you want to manage, make sure it has only one subview
    private weak var scrollView: UIScrollView?
    
    private var keyboardHeight: CGFloat = 0.0
    
    public init(scrollView: UIScrollView, shouldDismissKeyboardOnTap: Bool = false) {
        self.scrollView = scrollView
        registerForKeyboardNotifications()
        
        if shouldDismissKeyboardOnTap {
            let tap = UITapGestureRecognizer(
                target: scrollView,
                action: #selector(UIView.endEditing)
            )
            tap.cancelsTouchesInView = false
            scrollView.addGestureRecognizer(tap)
        }
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardChangeFrame(_:)),
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onKeyboardDisappear(_:)),
            name: UIResponder.keyboardDidHideNotification,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func onKeyboardChangeFrame(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardRect: CGRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else {
            return
        }
        keyboardHeight = keyboardRect.size.height
        
        if let currentView = currentView {
            scrollTo(view: currentView)
        }
    }
    
    @objc private func onKeyboardDisappear(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.2) {
            self.scrollView?.contentInset = UIEdgeInsets.zero
            self.scrollView?.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
    
    private func scrollTo(view: UIView) {
        guard let scrollView = scrollView,
              keyboardHeight > 0
        else {
            return
        }
        let keyboardHeightFromTop = scrollView.frame.height - keyboardHeight
        
        var scrollPosition = view.getOriginRelativeTo(
            view: scrollView
        ).y + view.frame.height - keyboardHeightFromTop + customOffset
        if scrollPosition < 0 {
            scrollPosition = 0
        }
        
        let newInsets = UIEdgeInsets(
            top: scrollView.contentInset.top,
            left: scrollView.contentInset.left,
            bottom: keyboardHeight + customOffset,
            right: scrollView.contentInset.right
        )
        DispatchQueue.main.async {
            self.scrollView?.contentInset = newInsets
            self.scrollView?.scrollIndicatorInsets = newInsets
            self.scrollView?.setContentOffset(CGPoint(x: 0, y: scrollPosition), animated: true)
        }
    }
}

public extension UIView {
    
    func getOriginRelativeTo(view: UIView, origin: CGPoint? = nil) -> CGPoint {
        let origin = origin ?? superview?.convert(self.frame.origin, to: view) ?? frame.origin
        guard let superview, superview != view else {
            return origin
        }
        return superview.getOriginRelativeTo(view: view, origin: origin)
    }
}
