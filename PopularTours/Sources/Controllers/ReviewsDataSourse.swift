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
  let collectionView: UICollectionView

  init(tour: Tour, collectionView: UICollectionView) {
    self.tour = tour
    self.collectionView = collectionView

    super.init()
  }

}

extension ReviewsDataSource: UICollectionViewDataSource {

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tour.reviews.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ReviewTextCell", forIndexPath: indexPath) as! ReviewCell

    cell.indexPath = indexPath
    cell.delegate = self

    return cell
  }

}

extension ReviewsDataSource: UICollectionViewDelegate {


}



extension ReviewsDataSource: UICollectionViewDelegateFlowLayout {

//  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//    return CGSize(width: collectionView.frame.width - 20, height: 100)
//  }
}


extension ReviewsDataSource: ReviewCellDelegate {

  func reviewText(sender: ReviewCell) -> String {
    let indexPath = sender.indexPath

    return tour.reviews[indexPath.item].title ?? "<>"
  }

  func reviewDescription(sender: ReviewCell) -> String {
    let indexPath = sender.indexPath

    return tour.reviews[indexPath.item].message ?? "<>"
  }

  func reviewSuperWidth(sender: ReviewCell) -> CGFloat {
    return collectionView.frame.width
  }

}
