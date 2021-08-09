//
//  Swift.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/16.
//

import Foundation

struct App {
    let trackID: Int
    let trackName: String
    let kind: String
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let screenshotUrls: [String]
    let description: String
    let sellerName: String
    let averageUserRating: Double
    let version: String
    let releaseDate: String
    let currentVersionReleaseDate: String
    let releaseNotes: String?
	
	init() {
		self.trackID = 0
		self.trackName = ""
		self.kind = ""
		self.artworkUrl60 = ""
		self.artworkUrl100 = ""
		self.artworkUrl512 = ""
		self.screenshotUrls = []
		self.description = ""
		self.sellerName = ""
		self.averageUserRating = 0.0
		self.version = ""
		self.releaseDate = ""
		self.currentVersionReleaseDate = ""
		self.releaseNotes = nil
	}
	
	init(trackID: Int, trackName: String, kind: String, artworkUrl60: String, artworkUrl512: String, artworkUrl100: String, screenshotUrls: [String], description: String, sellerName: String, averageUserRating: Double, version: String, releaseDate: String, currentVersionReleaseDate: String, releaseNotes: String?) {
		self.trackID = trackID
		self.trackName = trackName
		self.kind = kind
		self.artworkUrl60 = artworkUrl60
		self.artworkUrl100 = artworkUrl100
		self.artworkUrl512 = artworkUrl512
		self.screenshotUrls = screenshotUrls
		self.description = description
		self.sellerName = sellerName
		self.averageUserRating = averageUserRating
		self.version = version
		self.releaseDate = releaseDate
		self.currentVersionReleaseDate = currentVersionReleaseDate
		self.releaseNotes = releaseNotes
	}
}
