//
//  ReviewCell.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

protocol ReviewCellDelegate: class {

  func reviewText(sender: ReviewCell) -> String?
  func reviewDescription(sender: ReviewCell) -> String?
  func reviewAuthorName(sender: ReviewCell) -> String?
  func reviewRating(sender: ReviewCell) -> String?

}

class ReviewCell: UICollectionViewCell {

  weak var delegate: ReviewCellDelegate?

  var indexPath: NSIndexPath!

}

class ReviewTextCell: ReviewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!

  override func layoutSubviews() {
    titleLabel.text = delegate?.reviewText(self)
    textLabel.text = delegate?.reviewDescription(self)
    nameLabel.text = delegate?.reviewAuthorName(self)
    ratingLabel.text = delegate?.reviewRating(self)

    updateConstraintsIfNeeded()

    super.layoutSubviews()
  }

  override func prepareForReuse() {
    titleLabel.text = nil
    textLabel.text = nil
    nameLabel.text = nil
    ratingLabel.text = nil
  }
  
}
