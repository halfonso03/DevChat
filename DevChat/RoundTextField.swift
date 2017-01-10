//
//  RoundTextField.swift
//  DevChat
//
//  Created by Alfonso, Hector I. on 12/29/16.
//  Copyright © 2016 Alfonso, Hector I. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundTextField : UITextField {
    
    @IBInspectable
    var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable
    var bgColor: UIColor? {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    @IBInspectable
    var placeholderColor: UIColor? {
        didSet {
            let attrString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: attrString, attributes: [NSForegroundColorAttributeName: placeholderColor!])
            attributedPlaceholder = str
        }
    }
}
