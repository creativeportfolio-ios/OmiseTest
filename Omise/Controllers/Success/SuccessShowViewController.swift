//
//  SuccessShowViewController.swift
//  Omise
//
//  Created by techflitter on 2/15/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import UIKit

class SuccessShowViewController: UIViewController {
 
    @IBOutlet weak var btnNavigateToFirstScreen: UIButton!
    
    //MARK : - ViewDidLoad Method -
    override func viewDidLoad() {
        super.viewDidLoad()
       self.title = "Payment Successfull"
        btnNavigateToFirstScreen.layer.cornerRadius = 3.0
    }
    

    @IBAction func goBackToFirstScreen(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
