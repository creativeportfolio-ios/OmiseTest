//
//  Constants.swift
//  Omise
//
//  Created by techflitter on 2/15/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import Foundation
import UIKit

func alertShowWithOK(_ title : String, message : String, self : UIViewController) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
}
