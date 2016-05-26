//
//  ApiManager.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import Wrap

protocol ApiManagerProtocol {

  func reviews(tour: Tour, completion: [Review] -> Void)

}

public struct RequestParameters {

  enum SortBy: String, WrappableEnum {
    // Modern Swift styleguide is lowercase for enum cases
    case dateOfReview = "date_of_review"
  }

  enum SortDirection: String, WrappableEnum {
    case ASC, DESC
  }

  var
  count     = 5,
  page      = 0,
  rating    = 0,
  sortBy    = SortBy.dateOfReview,
  direction = SortDirection.DESC
  
}

final class ApiManager: ApiManagerProtocol {

  let baseURL: String

  init(baseURL: String) {
    self.baseURL = baseURL
  }


  private let networkManager: NetworkManagerProtocol = NetworkManager()

  func reviews(tour: Tour, completion: [Review] -> Void) {
    let requestUrl = "\(baseURL)/\(tour.URI.tourCityId)/\(tour.URI.tourId)/reviews.json"

    let requestParameters = RequestParameters()

    networkManager.makeRequest(requestUrl, method: .GET, parameters: try? Wrap(requestParameters)) { (JSON, error) in
      if let error = error {
        print(error)
      } else if let JSON = JSON {
        let reviews = Review.fromArray(JSON)

        completion(reviews)
      }
    }

  }

}
