//
//  Model.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import Foundation

// MARK: - AppStoreResponse
struct AppStoreResponse: Codable {
    let resultCount: Int
    let apps: [App]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case apps = "results"
    }
}

// MARK: - App
struct App: Codable {
    let ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistViewURL: String
    let screenshotUrls: [String]
    let isGameCenterEnabled: Bool
    let supportedDevices, advisories: [String]
    let kind: String
    let features: [String]
    let minimumOSVersion, trackCensoredName: String
    let languageCodesISO2A: [String]
    let fileSizeBytes, formattedPrice, contentAdvisoryRating: String
    let averageUserRatingForCurrentVersion: Double
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let trackViewURL: String
    let trackContentRating: String
    let genreIDS: [String]
    let releaseDate: String
    let trackID: Int // 필요
    let trackName, sellerName, primaryGenreName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let currentVersionReleaseDate: String
    let releaseNotes: String
    let primaryGenreID: Int
    let version, wrapperType: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let resultDescription, currency, bundleID: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl60, artworkUrl512, artworkUrl100
        case artistViewURL = "artistViewUrl"
        case screenshotUrls, isGameCenterEnabled, supportedDevices, advisories, kind, features
        case minimumOSVersion = "minimumOsVersion"
        case trackCensoredName, languageCodesISO2A, fileSizeBytes, formattedPrice, contentAdvisoryRating, averageUserRatingForCurrentVersion, userRatingCountForCurrentVersion, averageUserRating
        case trackViewURL = "trackViewUrl"
        case trackContentRating
        case genreIDS = "genreIds"
        case releaseDate
        case trackID = "trackId"
        case trackName, sellerName, primaryGenreName, isVppDeviceBasedLicensingEnabled, currentVersionReleaseDate, releaseNotes
        case primaryGenreID = "primaryGenreId"
        case version, wrapperType
        case artistID = "artistId"
        case artistName, genres, price
        case resultDescription = "description"
        case currency
        case bundleID = "bundleId"
        case userRatingCount
    }
}
