//
//  FilterViewController.swift
//  PopularTours
//
//  Created by Marat S. on 27.05.16.
//  Copyright © 2016 m4rr. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

  var filterHandle: Optional<(filterValue: Int) -> Void> = nil
  var filterValue = 0 {
    didSet {
      filterHandle?(filterValue: filterValue)
      tableView?.cellForRowAtIndexPath(NSIndexPath(forRow: oldValue, inSection: 0))?.accessoryType = .None
      tableView?.cellForRowAtIndexPath(NSIndexPath(forRow: filterValue, inSection: 0))?.accessoryType = .Checkmark
    }
  }

  private let filterItems = [
    "No Filter", "★", "★ ★", "★ ★ ★", "★ ★ ★ ★", "★ ★ ★ ★ ★"
  ]

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
  }

}

extension FilterViewController: UITableViewDataSource {

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterItems.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("FilterCell", forIndexPath: indexPath)

    cell.accessoryType = indexPath.row == filterValue ? .Checkmark : .None
    cell.textLabel?.text = filterItems[indexPath.row]

    if indexPath.row == 0 {
      cell.textLabel?.textColor = UIColor.blackColor()
    }

    return cell
  }

}

extension FilterViewController: UITableViewDelegate {

  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    tableView.deselectRowAtIndexPath(indexPath, animated: true)

    filterValue = indexPath.row

    // Dismiss Filter not immediately, but in a small time. For better UX.
    dismissAfter(0.5)
  }

  private func dismissAfter(time: Float) {
    let floatNSec = Float(NSEC_PER_SEC)
    let delay = Int64(time * floatNSec)
    let popTime = dispatch_time(DISPATCH_TIME_NOW, delay)

    dispatch_after(popTime, dispatch_get_main_queue()) {
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }

}
