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

}

class ReviewCell: UITableViewCell {

  weak var delegate: ReviewCellDelegate?

  var indexPath: NSIndexPath!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  override func layoutSubviews() {
    textLabel?.numberOfLines = 0
    textLabel?.text = delegate?.reviewText(self)
    detailTextLabel?.numberOfLines = 0
    detailTextLabel?.text = delegate?.reviewDescription(self)

    super.layoutSubviews()
  }

}

