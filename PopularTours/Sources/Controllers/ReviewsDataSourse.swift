//
//  ReviewsDataSourse.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import Foundation
import UIKit

class ReviewsDataSource: NSObject {

  let tour: Tour

  init(tour: Tour, tableView: UITableView) {
    self.tour = tour

    super.init()
  }

}

extension ReviewsDataSource: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tour.reviews.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("ReviewCell", forIndexPath: indexPath) as! ReviewCell

    cell.indexPath = indexPath
    cell.delegate = self

    return cell
  }

}

extension ReviewsDataSource: UITableViewDelegate {

}

extension ReviewsDataSource: ReviewCellDelegate {

  func reviewText(sender: ReviewCell) -> String {
    let indexPath = sender.indexPath

    return tour.reviews[indexPath.row].title ?? "<>"
  }

  func reviewDescription(sender: ReviewCell) -> String {
    let indexPath = sender.indexPath

    return tour.reviews[indexPath.row].message ?? "<>"
  }

}
