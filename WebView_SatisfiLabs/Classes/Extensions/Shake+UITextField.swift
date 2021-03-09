//
//  Shake+UITextField.swift
//  WebView_SatisfiLabs
//
//  Created by Vinay Bharwani on 2/8/21.
//

import UIKit

extension UITextField {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.06
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 7.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 7.0, y: self.center.y)
        layer.add(animation, forKey: "position")
    }
    
}
