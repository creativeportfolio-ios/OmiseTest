//
//  Extension.swift
//  Omise
//
//  Created by techflitter on 2/15/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import Foundation
import UIKit


extension UIView{
    
    @IBInspectable var shadowOffset: CGSize{
        get{
            return self.layer.shadowOffset
        }
        set{
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor{
        get{
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set{
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat{
        get{
            return self.layer.shadowRadius
        }
        set{
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float{
        get{
            return self.layer.shadowOpacity
        }
        set{
            self.layer.shadowOpacity = newValue
        }
    }
}

extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
    var hasOnlyNumbers: Bool {
        return self.filter("01234567890".contains).count == self.count
    }
}
