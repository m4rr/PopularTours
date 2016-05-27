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
  private var filterValue = 0 {
    didSet {
      showReviews()
    }
  }

  private lazy var dataSource: ReviewsDataSource = ReviewsDataSource(tour: self.tour, collectionView: self.collectionView)

  private let apiManager: ApiManager = ApiManager(baseURL: "https://www.getyourguide.com")

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(tour != nil, "A tour object should be provided to ReviewsViewController")
    
    collectionView.dataSource = dataSource
    collectionView.delegate = dataSource
    collectionView.contentInset.top = 10
    collectionView.contentInset.bottom = 10

    showReviews()
  }

  private func showReviews() {
    apiManager.reviews(tour, rating: filterValue) { (reviews) in
      self.tour.reviews = reviews

      // Response will be returned to the main thread.
      self.collectionView.reloadData()
    }
  }

  @IBAction func unwindToReviews(segue: UIStoryboardSegue) {

  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let identifier = segue.identifier else {
      return
    }

    switch identifier {
    case "showFilter":
      guard let nc = segue.destinationViewController as? UINavigationController, dc = nc.topViewController as? FilterViewController else {
        return
      }

      dc.filterValue = self.filterValue
      dc.filterHandle = { filterValue in
        self.filterValue = filterValue
      }
    default:
      ()
    }
  }

}
