//
//  MyProfileProvider.swift
//  Waymaker

import Foundation

class CharityListViewProvider {
    func charityList(successHandler: @escaping (_ response: CharityResponse) -> Void, errorHandler: @escaping (_ error: Error) -> Void) {
        NetworkManager.makeRequest(OmiseHttpRouter.charityListData()).onSuccess { (response: CharityResponse) in
            successHandler(response)
            }.onFailure { (error) in
                errorHandler(error)
                print(error.localizedDescription)
        }
    }
}
