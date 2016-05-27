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

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return cellSizeAt(indexPath: indexPath)
  }

  private func cellSizeAt(indexPath indexPath: NSIndexPath) -> CGSize {
    let review = reviewAt(indexPath: indexPath)
    let spacing: CGFloat = 8
    let baseFrame = collectionView.frame.insetBy(dx: spacing, dy: spacing)
    var fullHeight = spacing

    let label = UILabel(frame: baseFrame)
    label.numberOfLines = 0

    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle2)
    label.text = review.title
    label.sizeToFit()

    fullHeight += label.frame.height
    fullHeight += spacing

    label.frame = baseFrame

    label.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    label.text = review.message
    label.sizeToFit()

    fullHeight += label.frame.height
    fullHeight += spacing

    fullHeight += 18 // fixed-height "author name" label
    fullHeight += spacing

    return CGSize(width: collectionView.frame.width, height: fullHeight)
  }

}

extension ReviewsDataSource: ReviewCellDelegate {

  private func reviewAt(indexPath indexPath: NSIndexPath) -> Review {
    return tour.reviews[indexPath.item]
  }

  func reviewText(sender: ReviewCell) -> String? {
    return reviewAt(indexPath: sender.indexPath).title
  }

  func reviewDescription(sender: ReviewCell) -> String? {
    return reviewAt(indexPath: sender.indexPath).message
  }

  func reviewAuthorName(sender: ReviewCell) -> String? {
    return reviewAt(indexPath: sender.indexPath).author
  }

  func reviewRating(sender: ReviewCell) -> String? {
    let rating = reviewAt(indexPath: sender.indexPath).rating

    // Compose n-star string.
    let ratingByStars = (0..<Int(round(rating))).reduce("") { last, _ in
      return last + "★"
    }

    return ratingByStars
  }

}
