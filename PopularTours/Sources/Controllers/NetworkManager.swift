//
//  NetworkManager.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import Alamofire

public typealias CompletionHandler = (json: AnyObject?, error: ErrorType?) -> Void

public protocol NetworkManagerProtocol {

  func makeRequest(URL: URLStringConvertible,
                   method: Alamofire.Method,
                   parameters: [String: AnyObject]?,
                   completion: CompletionHandler)

}

public final class NetworkManager {

  private let manager = Manager.sharedInstance

}

extension NetworkManager: NetworkManagerProtocol {

  public func makeRequest(URL: URLStringConvertible, method: Alamofire.Method, parameters ps: [String : AnyObject]?, completion: CompletionHandler) {

    manager
      .request(method, URL, parameters: ps)
      .responseJSON { (response) in
        switch response.result {
        case .Success(let value):
          completion(json: value, error: nil)
        case .Failure(let error):
          completion(json: nil, error: error)
        }
    }
    
  }
  
}
