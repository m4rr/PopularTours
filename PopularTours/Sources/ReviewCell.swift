//
//  ReviewCell.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

protocol ReviewCellDelegate: class {

  func reviewText(sender: ReviewCell) -> String

  func reviewDescription(sender: ReviewCell) -> String

  func reviewSuperWidth(sender: ReviewCell) -> CGFloat

}

class ReviewCell: UICollectionViewCell {

  weak var delegate: ReviewCellDelegate?

  var indexPath: NSIndexPath!

  override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    layoutAttributes.frame.size.width = delegate!.reviewSuperWidth(self)
    return layoutAttributes
  }

}

class ReviewTextCell: ReviewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!

  override func layoutSubviews() {
    titleLabel.text = delegate?.reviewText(self)
    textLabel.text = delegate?.reviewDescription(self)

    updateConstraintsIfNeeded()

    super.layoutSubviews()
  }
  
}
