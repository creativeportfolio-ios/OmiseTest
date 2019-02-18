//
//  CharityDonationView.swift
//  Omise

import Foundation

protocol CharityDonationView : class {
    func responseSuccess(_ message : CharityDonationResponse)
    func responseError(_ message: String)
}
