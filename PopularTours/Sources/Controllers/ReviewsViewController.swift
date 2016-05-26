//
//  ViewController.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!

  // Assume a tour object should be provided to ReviewsViewController on initialization.
  var tour: Tour! = Tour()

  private lazy var dataSource: ReviewsDataSource = ReviewsDataSource(tour: self.tour, collectionView: self.collectionView)

  private let apiManager: ApiManagerProtocol = ApiManager(baseURL: "https://www.getyourguide.com")

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(tour != nil, "A tour object should be provided to ReviewsViewController")

    
    collectionView.dataSource = dataSource
    collectionView.delegate = dataSource
    collectionView.contentInset.top = 10
    collectionView.contentInset.bottom = 10

    showReviews()
  }

//  override func viewDidAppear(animated: Bool) {
//    super.viewDidAppear(animated)
//
//    let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//    flowLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 150)
//  }

  private func showReviews() {
    apiManager.reviews(tour) { (reviews) in
      self.tour.reviews = reviews
      NSOperationQueue.mainQueue().addOperationWithBlock {
        self.collectionView.reloadData()
      }
    }
  }

}
