//
//  NetworkManager.swift
//  CheckIn
//
//  Created by DOVU Solutions on 07/05/18.
//  Copyright © 2018 DOVU Solutions. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import BrightFutures

enum NetworkError: Error {
    case notFound
    case unauthorized
    case forbidden
    case nonRecoverable
    case errorString(String?)
    case unprocessableEntity(String?)
    case other
}

struct NetworkManager {
    
    static let networkQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "com.DOVU").networking-queue", attributes: .concurrent)
    
    static func makeRequest<T: Mappable>(_ urlRequest: URLRequestConvertible) ->
        Future<T, NetworkError> {
            let promise = Promise<T, NetworkError>()
            
            let request = Alamofire.request(urlRequest)
                .validate()
                .responseObject(queue: networkQueue) { (response: DataResponse<T>)-> Void in
                    print("\nResponse: \(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)\n")
                    
                    switch response.result {
                    case .success:
                        promise.success(response.result.value!)
                        
                    case .failure
                        where response.response?.statusCode == 400:
                        var jsonData: String?
                        if let data = response.data {
                            jsonData = String(data: data, encoding: .utf8)
                        }
                        promise.failure(.unprocessableEntity(jsonData))
                        
                    case .failure
                        where response.response?.statusCode == 401:
                        var jsonData: String?
                        if let data = response.data {
                            jsonData = String(data: data, encoding: .utf8)
                        }
                        promise.failure(.unprocessableEntity(jsonData))
                        
                    case .failure
                        where response.response?.statusCode == 403:
                        promise.failure(.forbidden)
                        
                    case .failure
                        where response.response?.statusCode == 404:
                        promise.failure(.notFound)
                        
                    case .failure
                        where response.response?.statusCode == 422:
                        var jsonData: String?
                        
                        if let data = response.data {
                            jsonData = String(data: data, encoding: .utf8)
                        }
                        promise.failure(.unprocessableEntity(jsonData))
                        
                    case .failure
                        where response.response?.statusCode == 500:
                        promise.failure(.nonRecoverable)
                        
                    case .failure
                        where response.response?.statusCode == 405:
                        promise.failure(.nonRecoverable)
                        
                    case .failure
                        where response.response?.statusCode == 426:
                        promise.failure(.nonRecoverable)

                    case .failure:
                        promise.failure(.other)
                    }
            }
            
            debugPrint(request)
            
            return promise.future
    }

}
