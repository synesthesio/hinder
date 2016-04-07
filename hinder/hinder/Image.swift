//
//  Image.swift
//  hinder
//
//  Created by synesthesia on 4/7/16.
//  Copyright © 2016 synesthesia. All rights reserved.
//

import Foundation

class Image {
	let imageName:String
	let imageDesc:String
	let imageURL:NSURL
	
	init(imageName:String, imageDesc:String, imageURL:NSURL) {
		self.imageName = imageName
		self.imageDesc = imageDesc
		self.imageURL = imageURL
	}
	
}