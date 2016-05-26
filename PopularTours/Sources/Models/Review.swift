//
//  Review.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

struct Review {

  var
  author:           String?,
  date:             String?,
  foreignLanguage = false,
  languageCode:     String?,
  message:          String?,
  reviewId:         Int?,
  title:            String?

  private var
  _rating:          String?

  var rating: Double {
    return Double(_rating ?? "") ?? 0
  }

  static func from(json json: AnyObject) -> Review? {
    return Mapper<Review>().map(json)
  }

  static func from(jsonArray json: AnyObject) -> [Review] {
    if let
      jsonDic = json as? [String: AnyObject],
      data = jsonDic["data"],
      reviews = Mapper<Review>().mapArray(data) {

      return reviews ?? []
    }

    return []
  }

}

extension Review: Mappable {

  init?(_ map: Map) {}

  mutating func mapping(map: Map) {
    author          <- map["author"]
    date            <- map["date"]
    foreignLanguage <- map["foreignLanguage"]
    languageCode    <- map["languageCode"]
    message         <- map["message"]
    _rating         <- map["rating"]
    reviewId        <- map["review_id"]
    title           <- map["title"]
  }

}
