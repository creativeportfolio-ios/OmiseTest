//
//  MyProfilePresenter.swift
//  Waymaker
//
//

import Foundation


class CharityListPresenter {
    let provider : CharityListViewProvider
    weak private var charityView : CharityListView?
    
    init(provider : CharityListViewProvider) {
        self.provider = provider
    }
    
    func attachView(view : CharityListView?){
        guard let view = view else {return}
        charityView = view
    }
    
    func charityList() {
        provider.charityList(successHandler: { (response) in
            self.charityView?.responseSuccess(response)
        }) { (error) in
            self.charityView?.responseError(error.localizedDescription)
        }
    }
}
