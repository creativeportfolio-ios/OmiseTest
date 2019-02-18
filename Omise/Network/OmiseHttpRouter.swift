//
//  CheckInHttpRouter.swift
//  CheckIn
//
//  Created by DOVU Solutions on 07/05/18.
//  Copyright © 2018 DOVU Solutions. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

public enum OmiseHttpRouter: URLRequestConvertible {
    
    case charityListData()
    case charityDonation(name : String, token : String, amount: Int)
    
    static var OAuthToken: String?

    var method: Alamofire.HTTPMethod {
        switch self {
        case
        .charityDonation:
            return .post
            
        case
        .charityListData:
            return .get
        }
    }
    
    var authorization: String? {
        switch self {
        case .charityListData,
             .charityDonation:
            return nil
        }
    }

    
    var path: String {
        switch self {
        case .charityListData:
            return "charities"
        case .charityDonation:
            return "donations"
        }
    }
    
    var jsonParameters: [String: Any]? {
        switch self {

        default:
            return nil
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL.init(string: Configuration.baseURL() + path)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .charityDonation:
            do {
                let jsonData: NSData = try JSONSerialization.data(withJSONObject: self.jsonParameters ?? Dictionary(), options: JSONSerialization.WritingOptions.prettyPrinted) as NSData
                print("JSON Request: \(NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String)")
            }
            catch let error as NSError {
                print("Could not prepare request: \(error), \(error.userInfo)")
            }
            if let token = OmiseHttpRouter.OAuthToken {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            }
            return try JSONEncoding.default.encode(urlRequest, with: self.jsonParameters)
            
        case 
            .charityListData:
             return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
 
        }
    }
}
