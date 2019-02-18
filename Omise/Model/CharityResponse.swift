//
//  CharityResponse.swift
//  Omise

import Foundation
import ObjectMapper

//{
//    "total": 10,
//    "data": [
//    {
//    "id": 7331,
//    "name": "Habitat for Humanity",
//    "logo_url": "http://www.adamandlianne.com/uploads/2/2/1/6/2216267/3231127.gif"
//    }
//    ]
//}

class CharityResponse : Mappable {
    var total : String?
    var data : [CharityResponseData]?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        total <- map["total"]
        data <- map["data"]
    }
}

class CharityResponseData : Mappable {
    var id : Int?
    var name : String?
    var logo_url : String?
    
    required init?(map: Map) {
    }
    
    // Mappable
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        logo_url <- map["logo_url"]
    }

}
