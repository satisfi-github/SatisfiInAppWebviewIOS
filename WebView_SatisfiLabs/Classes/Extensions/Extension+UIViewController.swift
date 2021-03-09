//
//  Extension+UIViewController.swift
//  WebView_SatisfiLabs
//
//  Created by Vinay Bharwani on 2/17/21.
//

import UIKit

extension UIViewController {


    /// This hides the keyboard when tapped anywhere on screen
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        self.view.addGestureRecognizer(tap)
    }

    /// Done button of the keyboard also hides the keyboard when no in use
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextTextField.becomeFirstResponder()
        } else{
            textField.resignFirstResponder()
        }
        return false
    }

}
