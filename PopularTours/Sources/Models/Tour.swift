//
//  Tour.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import ObjectMapper

struct TourURI {

  var tourId: String
  var tourCityId: String

}

class Tour {

  var reviews: [Review] = []

  // Assume identifiers of tours are obtained by response of common `get_tours` request.
  var URI = TourURI(tourId: "tempelhof-2-hour-airport-history-tour-berlin-airlift-more-t23776", tourCityId: "berlin-l17")

  required init?(_ map: Map) {}

  init() {

  }

}

extension Tour: Mappable {


   func mapping(map: Map) {
    reviews <- map["data"]
  }

}
