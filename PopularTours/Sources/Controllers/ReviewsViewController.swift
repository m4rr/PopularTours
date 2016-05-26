//
//  ViewController.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  // Assume a tour object should be provided to ReviewsViewController on initialization.
  var tour: Tour! = Tour()

  private lazy var dataSource: ReviewsDataSource = ReviewsDataSource(tour: self.tour, tableView: self.tableView)

  private let apiManager: ApiManagerProtocol = ApiManager(baseURL: "https://www.getyourguide.com")

  override func viewDidLoad() {
    super.viewDidLoad()

    assert(tour != nil, "A tour object should be provided to ReviewsViewController")

    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.dataSource = dataSource
    tableView.delegate = dataSource

    showReviews()
  }

  private func showReviews() {
    apiManager.reviews(tour) { (reviews) in
      self.tour.reviews = reviews
      NSOperationQueue.mainQueue().addOperationWithBlock {
        self.tableView.reloadData()
      }
    }
  }

}
