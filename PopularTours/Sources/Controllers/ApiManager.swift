//
//  ApiManager.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import Wrap

public struct RequestParameters {

  enum SortBy: String, WrappableEnum {
    // Modern Swift styleguide is lowercased enum cases.
    case dateOfReview = "date_of_review"
  }

  enum SortDirection: String, WrappableEnum {
    case ASC, DESC
  }

  var count: Int, page: Int, rating: Int
  var sortBy: SortBy
  var direction: SortDirection

}

final class ApiManager {

  let baseURL: String

  init(baseURL: String) {
    self.baseURL = baseURL
  }

  private let networkManager: NetworkManagerProtocol = NetworkManager()

  func reviews(tour: Tour, count: Int = 15, page: Int = 0, rating: Int = 0, completion: ([Review]?, ErrorType?) -> Void) {

    let requestUrl = "\(baseURL)/\(tour.URI.tourCityId)/\(tour.URI.tourId)/reviews.json"

    let requestParameters = RequestParameters(count: count, page: page, rating: rating, sortBy: .dateOfReview, direction: .DESC)

    networkManager.makeRequest(requestUrl, method: .GET, parameters: try? Wrap(requestParameters)) { (json, error) in
      if let  error = error {
        completion(nil, error)
      } else if let json = json {
        let reviews = Review.from(jsonArray: json)

        completion(reviews, nil)
      }
    }

  }

}
