//
//  MyProfileView.swift
//  Waymaker
//
//  Created by techflitter on 1/8/19.
//  Copyright © 2019 Marvel. All rights reserved.
//

import Foundation

protocol CharityListView : class {
    func responseSuccess(_ data : CharityResponse?)
    func responseError(_ message : String)
}
