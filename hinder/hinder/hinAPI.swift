//
//  hinAPI.swift
//  hinder
//
//  Created by synesthesia on 4/6/16.
//  Copyright © 2016 synesthesia. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let urlPath:NSURL = NSURL(string: "https://hinge-homework.s3.amazonaws.com/client/services/homework.json")!
let session:NSURLSession = {let config = NSURLSessionConfiguration.defaultSessionConfiguration()
	return NSURLSession(configuration: config)}()

let queue = NSOperationQueue()
var images = [NSManagedObject]()




//represent possible errors for API with enum

enum hinAPIError: ErrorType {
	case InvalidJSONData
}


class hinAPI: NSObject {


	
	
	
	//download image
 func downloadImageData() {
	


		queue.addOperationWithBlock() {
				// download in the background
			let request = NSURLRequest(URL: urlPath)
			let task = session.dataTaskWithRequest(request) {
				(data, response, error) -> Void in
				
				if let jsonData = data {
					
					do { let jsonObject:AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
					print(jsonObject)
				}
					catch let error {print("Error creating JSON object:\(error)") }
				}
				
				else if let requestError = error {print("error fetching images: \(requestError)")}
				else { print("unexpected request error")}
			}
			task.resume()
			
			
			
			NSOperationQueue.mainQueue().addOperationWithBlock() {
				// when done, update your UI and/or model on the main queue
			}
		}
		
		
	
	
	}
	
	
	enum imageResult {
		case Success([Image])
		case Failure (ErrorType)
	}
	static func photosFromJSONData(data:NSData) -> imageResult
	{
	
		do {
			let jsonObject:AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
			
			guard let
				jsonDictionary = jsonObject as? [NSObject:AnyObject],
				photos = jsonDictionary["photos"] as? [String:AnyObject],
				photosArray = photos["photo"] as? [[String:AnyObject]] else {
					return .Failure(hinAPIError.InvalidJSONData)
			}
			print("the json dictionary data is \(jsonDictionary)")
			
			var finalImages = [Image]()
			return .Success(finalImages)
			
		}
		catch let error {
			return .Failure(error)
		}
		
	}
	
	
	
	
	
	//save image as NSManagedObject
	
	
	func persistImage(name:String, desc:String) {
		
		//reference default managed object context via app delegate
		let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
		
		let managedContext = appDelegate.managedObjectContext
		
		let entity = NSEntityDescription.entityForName("Image", inManagedObjectContext: managedContext)
		
		let image = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
		
		image.setValue(name, forKey: "name")
		
		do {	try managedContext.save()
			images.append(image)
		} catch let error as NSError {
			print("couldn't save \(error), \(error.userInfo)")
		}
		
		
	}

	
}
