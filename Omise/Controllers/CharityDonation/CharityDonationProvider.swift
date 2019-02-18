//
//  CharityListProvider.swift
//  Omise
//
//  Created by techflitter on 2/15/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import Foundation


class CharityDonationProvider {
    func charityDonation(name : String, token : String, amount : Int,successHandler: @escaping (_ response: CharityDonationResponse) -> Void,
                     errorHandler: @escaping (_ error: Error) -> Void) {
        
        NetworkManager.makeRequest(OmiseHttpRouter.charityDonation(name: name, token: token, amount: amount)).onSuccess { (response: CharityDonationResponse) in
            successHandler(response)
            }.onFailure { (error) in
                errorHandler(error)
                print(error.localizedDescription)
        }
    }
}
