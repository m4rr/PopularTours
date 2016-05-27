//
//  ViewController.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit
import Reachability

class ReviewsViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var unreachableIndicator: UIVisualEffectView!

  // Assume a tour object should be provided to ReviewsViewController on initialization.
  var tour: Tour! = Tour()
  private var filterValue = 0 {
    didSet {
      showReviews()
    }
  }

  private lazy var dataSource: ReviewsDataSource = ReviewsDataSource(tour: self.tour, collectionView: self.collectionView)

  private let apiManager: ApiManager = ApiManager(baseURL: "https://www.getyourguide.com")

  private var reach: Reachability? = Reachability.reachabilityForInternetConnection()

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(tour != nil, "A tour object should be provided to ReviewsViewController")

    setupReachability()
    setupCollectionView()

    showReviews()
  }

  // Checking for internet connectivity.
  private func setupReachability() {
    reach?.reachableBlock = { _ in
      dispatch_async(dispatch_get_main_queue()) {
        self.toggleUnreachableIndicator(true)

        self.showReviews()
      }
    }

    reach?.unreachableBlock = { _ in
      dispatch_async(dispatch_get_main_queue()) {
        self.toggleUnreachableIndicator(false)
      }
    }

    reach?.startNotifier()
  }

  private func setupCollectionView() {
    collectionView.dataSource = dataSource
    collectionView.delegate = dataSource
    collectionView.contentInset.top = 10
    collectionView.contentInset.bottom = 10
  }

  private func toggleUnreachableIndicator(hidden: Bool) {
    self.navigationItem.leftBarButtonItem?.enabled = hidden
    self.navigationItem.rightBarButtonItem?.enabled = hidden

    UIView.transitionWithView(unreachableIndicator, duration: 0.3, options: .TransitionFlipFromBottom, animations: {
      self.unreachableIndicator.hidden = hidden
    }, completion: nil)
  }

  private func showReviews() {
    apiManager.reviews(tour, rating: filterValue) { (reviews, error) in
      // Response will be returned to the main thread.
      if let _ = error {
        self.toggleUnreachableIndicator(false)
      } else if let reviews = reviews {
        self.toggleUnreachableIndicator(true)

        self.tour.reviews = reviews

        self.collectionView.reloadData()
      }
    }
  }

  @IBAction func unwindToReviews(segue: UIStoryboardSegue) {

  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard segue.identifier == "showFilter",
      let navController = segue.destinationViewController as? UINavigationController,
      destController = navController.topViewController as? FilterViewController else {
        return
    }

    destController.filterValue = self.filterValue
    destController.filterHandle = { filterValue in
      self.filterValue = filterValue
    }
  }

}
