//
//  HomePageViewController.swift
//  hinder
//
//  Created by synesthesia on 4/6/16.
//  Copyright © 2016 synesthesia. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	

@IBOutlet weak var imageV:UIImageView!
@IBOutlet weak var tableView: UITableView!


var images = [NSManagedObject]()

 override	func viewDidLoad() {
		super.viewDidLoad()
	
	let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
	let managedContext = appDelegate.managedObjectContext
	let fetchRequest = NSFetchRequest(entityName: "Image")
	do {
		let results = try managedContext.executeFetchRequest(fetchRequest)
		images = results as! [NSManagedObject]
		
	} catch let error as NSError {
		print("Could not fetch \(error), \(error.userInfo)")
	}
	
	
	
	
	
	
	
	title = "\"The List\""

	tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	
	}
	
	func tableView(tableView: UITableView,
  numberOfRowsInSection section: Int) -> Int {
  return images.count
	}
 
	func tableView(tableView: UITableView,
  cellForRowAtIndexPath
  indexPath: NSIndexPath) -> UITableViewCell {
		
  let cell =
  tableView.dequeueReusableCellWithIdentifier("Cell")
	
	let image = images[indexPath.row]
		
  cell!.textLabel!.text = image.valueForKey("name") as? String
	
		
  return cell!
	}



//get data

//some func that downloads data from api for table
	func loadData() {




		//reload data
		self.tableView.reloadData()
	}
	
	
	
	
	
}