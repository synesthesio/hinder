//
//  HomePageViewController.swift
//  hinder
//
//  Created by synesthesia on 4/6/16.
//  Copyright © 2016 synesthesia. All rights reserved.
//

import Foundation
import UIKit


class HomePageViewController: UIViewController, UITableViewDataSource {
	
@IBOutlet weak var tableView: UITableView!
var names = [String]()




 override	func viewDidLoad() {
		super.viewDidLoad()
	
	title = "\"The List\""

	tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	
	}
	
	func tableView(tableView: UITableView,
  numberOfRowsInSection section: Int) -> Int {
  return names.count
	}
 
	func tableView(tableView: UITableView,
  cellForRowAtIndexPath
  indexPath: NSIndexPath) -> UITableViewCell {
		
  let cell =
  tableView.dequeueReusableCellWithIdentifier("Cell")
		
  cell!.textLabel!.text = names[indexPath.row]
		
  return cell!
	}
	
	
}