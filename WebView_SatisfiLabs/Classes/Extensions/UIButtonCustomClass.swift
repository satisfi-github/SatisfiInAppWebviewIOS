//
//  UIButtonCustomClass.swift
//  WebView_SatisfiLabs
//
//  Created by Vinay Bharwani on 2/8/21.
//

import UIKit

@IBDesignable class UIButtonCustomClass:UIButton{
    
    // MARK: - Initialization
      override init(frame: CGRect) {
          super.init(frame: frame)
          setupView()
      }

      required init?(coder: NSCoder) {
          super.init(coder: coder)
          setupView()
      }
    
    // MARK: - UI Setup

    func setupView() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }

    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

}
