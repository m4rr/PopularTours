//
//  ViewController.swift
//  PopularTours
//
//  Created by Marat S. on 26.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

  private let apiManager: ApiManagerProtocol = ApiManager(baseURL: "https://www.getyourguide.com")

  override func viewDidLoad() {
    super.viewDidLoad()

    let t = Tour()

    apiManager.reviews(t) { (rs) in
      print(rs)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}
