//
//  CharityDonationResponse.swift
//  Omise
//
//  Created by techflitter on 2/15/19.
//  Copyright © 2019 techflitter. All rights reserved.
//

import Foundation
import ObjectMapper

//"success": true,
//"error_code": "insufficient_minerals",
//"error_message": "Card has insufficient balance."


class CharityDonationResponse : Mappable {
    var success : Bool?
    var message : String?
    var error_message : String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        error_message <- map["error_message"]
    }

}
