//
//  Utilities.swift
//  EPRS
//
//  Copyright © 2019 Matthias Bogarin, Daniel Vilajetid , Josh Persaud, Esau Cuellar. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 177/255, green: 149/255, blue: 58/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.layer.borderWidth = 3
        button.backgroundColor = UIColor.init(red: 0.07, green: 0.87, blue: 1.0, alpha: 1.0)
        button.layer.borderColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Gold Buttons
        button.layer.borderWidth = 3
        button.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1.0, alpha: 1.0)
        button.layer.borderColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        button.layer.cornerRadius = 15
        button.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)

    }
    
    
}
