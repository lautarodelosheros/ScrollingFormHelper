//
//  ViewController.swift
//  ScrollingFormHelper
//
//  Created by lautarodelosheros on 04/19/2021.
//  Copyright (c) 2021 lautarodelosheros. All rights reserved.
//

import UIKit
import ScrollingFormHelper

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var textField5: UITextField!
    @IBOutlet weak var textField6: UITextField!
    @IBOutlet weak var textField7: UITextField!
    @IBOutlet weak var textField8: UITextField!
    @IBOutlet weak var textField9: UITextField!
    @IBOutlet weak var textField10: UITextField!
    @IBOutlet weak var textField11: UITextField!
    @IBOutlet weak var textField12: UITextField!
    @IBOutlet weak var textField13: UITextField!
    @IBOutlet weak var textField14: UITextField!
    @IBOutlet weak var textField15: UITextField!
    @IBOutlet weak var textField16: UITextField!
    @IBOutlet weak var textField17: UITextField!
    @IBOutlet weak var textField18: UITextField!
    @IBOutlet weak var textField19: UITextField!
    @IBOutlet weak var textField20: UITextField!
    
    var scrollingFormHelper: ScrollingFormHelper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollingFormHelper = ScrollingFormHelper(
            scrollView: scrollView,
            shouldDismissKeyboardOnTap: true
        )
        setupTextFields()
    }
    
    private func setupTextFields() {
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField5.delegate = self
        textField6.delegate = self
        textField7.delegate = self
        textField8.delegate = self
        textField9.delegate = self
        textField10.delegate = self
        textField11.delegate = self
        textField12.delegate = self
        textField13.delegate = self
        textField14.delegate = self
        textField15.delegate = self
        textField16.delegate = self
        textField17.delegate = self
        textField18.delegate = self
        textField19.delegate = self
        textField20.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollingFormHelper?.currentView = textField
    }
}
