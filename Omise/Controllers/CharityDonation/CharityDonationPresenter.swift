//
//  CharityListPresenter.swift
//  Omise

import Foundation

class CharityDonationPresenter {
    let provider : CharityDonationProvider
    weak private var donationView : CharityDonationView?
    
    init(provider : CharityDonationProvider) {
        self.provider = provider
    }
    
    func attachView(view : CharityDonationView?){
        guard let view = view else {return}
        donationView = view
     }
    
    func callDonationAPI(name: String, token: String, amount: Int) {
        provider.charityDonation(name: name, token: token, amount: amount, successHandler: { (response) in
            self.donationView?.responseSuccess(response)
        }) { (error) in
            self.donationView?.responseError(error.localizedDescription)
        }
    }
}
