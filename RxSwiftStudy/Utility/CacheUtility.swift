//
//  CacheUtility.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/08/12.
//

import Foundation
import UIKit

class CacheUtility {
	static let shared = CacheUtility()
	
	var imageCache = NSCache<NSString, UIImage>()
	
	private init() {}
}
