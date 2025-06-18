//
//  KeyboardAwareScrollView.swift
//  KeyboardAwareScrollView
//
//  Created by Lautaro de los Heros on 19/04/2021.
//

import Foundation
import UIKit

public class KeyboardAwareScrollView: UIScrollView {
    
    /// Set here the currently focused view that will be scrolled to when the keyboard is presented
    public weak var currentView: UIView? {
        didSet {
            guard let currentView = currentView else { return }
            scrollTo(view: currentView)
        }
    }
    
    /// Offset that will be considered for the scroll view's bottom offset and the scroll offset to the currentView
    public var customOffset: CGFloat = 0.0
    
    /// Whether the keyboard should be dismissed when clicking on the scroll view or not
    @IBInspectable public var shouldDismissKeyboardOnTap: Bool = false {
        didSet {
            tapGesture.cancelsTouchesInView = false
            if shouldDismissKeyboardOnTap {
                addGestureRecognizer(tapGesture)
            } else {
                removeGestureRecognizer(tapGesture)
            }
        }
    }
    
    private var keyboardHeight: CGFloat = 0.0
    private lazy var tapGesture = UITapGestureRecognizer(
        target: self,
        action: #selector(UIView.endEditing)
    )
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
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
            self.contentInset = UIEdgeInsets.zero
            self.scrollIndicatorInsets = UIEdgeInsets.zero
        }
    }
    
    private func scrollTo(view: UIView) {
        guard keyboardHeight > 0 else {
            return
        }
        let keyboardHeightFromTop = frame.height - keyboardHeight
        
        var scrollPosition = view.getOriginRelativeTo(
            view: self
        ).y + view.frame.height - keyboardHeightFromTop + customOffset
        if scrollPosition < 0 {
            scrollPosition = 0
        }
        
        let newInsets = UIEdgeInsets(
            top: contentInset.top,
            left: contentInset.left,
            bottom: keyboardHeight + customOffset,
            right: contentInset.right
        )
        DispatchQueue.main.async {
            self.contentInset = newInsets
            self.scrollIndicatorInsets = newInsets
            self.setContentOffset(CGPoint(x: 0, y: scrollPosition), animated: true)
        }
    }
}

extension UIView {
    
    func getOriginRelativeTo(view: UIView, origin: CGPoint? = nil) -> CGPoint {
        let origin = origin ?? superview?.convert(self.frame.origin, to: view) ?? frame.origin
        guard let superview, superview != view else {
            return origin
        }
        return superview.getOriginRelativeTo(view: view, origin: origin)
    }
}
