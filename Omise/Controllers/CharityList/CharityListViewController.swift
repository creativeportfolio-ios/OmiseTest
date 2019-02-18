//
//  CharityListViewController.swift
//  Omise
//
//  Created by techflitter on 2/14/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import UIKit
import SDWebImage
import OmiseSDK

class CharityListTableViewCell : UITableViewCell {
    @IBOutlet weak var imgCharity : UIImageView!
    @IBOutlet weak var lblCharityNm : UILabel!
}

class CharityListViewController: UIViewController {
    @IBOutlet weak var charityTblView: UITableView!
    let presenter = CharityListPresenter(provider: CharityListViewProvider())
    var arrCharityList = [CharityResponseData]()
    var cardName = ""
    var cardTokenId  = ""
    let publicKey = "pkey_test_5exsa2odlh12licqx89"

    //MARK : - ViewDidLoad Method -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
    }
    
    //MARK : - ViewWillAppear Method -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callAPI()
    }
    
}

//MARK : - UITableView Methods - 
extension CharityListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCharityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharityListTableViewCell", for: indexPath) as! CharityListTableViewCell
        let obj = arrCharityList[indexPath.row]
        cell.imgCharity.sd_setImage(with: URL(string: obj.logo_url ?? ""), completed: nil)
        cell.lblCharityNm.text = obj.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let creditCardView = CreditCardFormViewController.makeCreditCardFormViewController(withPublicKey: publicKey)
        creditCardView.delegate = self
        creditCardView.handleErrors = true
        let navigationController = UINavigationController(rootViewController: creditCardView)
        present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}

extension CharityListViewController : CharityListView {
    func responseSuccess(_ data: CharityResponse?) {
        if let data = data?.data {
            arrCharityList = data
            charityTblView.reloadData()
        }
    }
    
    
    func responseError(_ message: String) {
        print("Error \(message)")
    }
    
    func callAPI() {
        presenter.charityList()
    }
}

// MARK: - Credit Card Form View Controller Delegate

extension CharityListViewController : CreditCardFormViewControllerDelegate {
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didSucceedWithToken token: Token) {
        cardName = token.card.name ?? ""
        cardTokenId = "\(token.id)"
        print("CreditCardToken \(token)")
        controller.dismiss(animated: true, completion: {
            let donationViewController = self.storyboard?.instantiateViewController(withIdentifier: "CharityDonationViewController") as! CharityDonationViewController
            donationViewController.cardName = self.cardName
            donationViewController.cardTokenId = self.cardTokenId
            self.navigationController?.pushViewController(donationViewController,
                                                         animated: true)
        })
    }
    
    func creditCardFormViewController(_ controller: CreditCardFormViewController, didFailWithError error: Error) {
        print("CreditCardError \(error)")
    }
    
    func creditCardFormViewControllerDidCancel(_ controller: CreditCardFormViewController) {
        print("cancel)")
        controller.dismiss(animated: true, completion: nil)
    }
}


// MARK: - Authorizing Payment View Controller Delegate

extension CharityListViewController: AuthorizingPaymentViewControllerDelegate {
    func authorizingPaymentViewController(_ viewController: AuthorizingPaymentViewController, didCompleteAuthorizingPaymentWithRedirectedURL redirectedURL: URL) {
        print(redirectedURL)
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func authorizingPaymentViewControllerDidCancel(_ viewController: AuthorizingPaymentViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
}



