//
//  CharityDonationViewController.swift
//  Omise

import UIKit

class CharityDonationViewController: UIViewController {

    @IBOutlet weak var txtDonation: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    var cardName = ""
    var cardTokenId = ""

    let presenter = CharityDonationPresenter(provider: CharityDonationProvider())

    //MARK : - ViewDidLoad Method -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        self.title = "Donation Amount"
        btnSubmit.layer.cornerRadius = 3.0
    }
    
    @IBAction func submitClicked(_ sender: UIButton) {
        if validation() {
            callDonationAPI()
        }
    }
}

extension CharityDonationViewController : CharityDonationView {
    
    func responseSuccess(_ message: CharityDonationResponse) {
        if let msg = message.error_message {
            alertShowWithOK("Omise", message : msg, self : self)
        }
        let successShowViewController = self.storyboard?.instantiateViewController(withIdentifier: "SuccessShowViewController") as! SuccessShowViewController
        self.navigationController?.present(successShowViewController, animated: true, completion: nil)
    }
    
    func responseError(_ message: String) {
        alertShowWithOK("Omise", message : message, self : self)
    }
    
    func validation() -> Bool {
        let donationAmount = txtDonation.text ?? ""
        if donationAmount.isEmpty {
            alertShowWithOK("Omise", message : PopupMessage.enterDonation.rawValue, self : self)
            return false
        } else if !donationAmount.hasOnlyNumbers {
            alertShowWithOK("Omise", message : PopupMessage.enterCorrectAmount.rawValue, self : self)
            return false
        }
        
        return true
    }
    
    func callDonationAPI() {
        presenter.callDonationAPI(name: cardName, token: cardTokenId, amount: Int(txtDonation.text!) ?? 00)
    }
    
}


extension CharityDonationViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        textField.resignFirstResponder()
    }
}
