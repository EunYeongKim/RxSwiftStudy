//
//  Model.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import Foundation

// MARK: - AppStoreDTO
struct AppStoreDTO: Codable {
    let resultCount: Int
    let appDTO: [AppDTO]
    
    enum CodingKeys: String, CodingKey {
        case resultCount
        case appDTO = "results"
    }
}

// MARK: - AppDTO
struct AppDTO: Codable {
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

    enum CodingKeys: String, CodingKey {
        case trackID = "trackId"
        case artworkUrl60, artworkUrl512, artworkUrl100, trackName, kind, screenshotUrls, description, sellerName, averageUserRating, version, releaseDate, releaseNotes, currentVersionReleaseDate
    }
}

extension AppDTO {
    func toEntity() -> App {
        return App(trackID: self.trackID,
                   trackName: self.trackName,
                   kind: self.kind,
                   artworkUrl60: self.artworkUrl60,
                   artworkUrl512: self.artworkUrl512,
                   artworkUrl100: self.artworkUrl100,
                   screenshotUrls: self.screenshotUrls,
                   description: self.description,
                   sellerName: self.sellerName,
                   averageUserRating: self.averageUserRating,
                   version: self.version,
                   releaseDate: self.releaseDate,
                   currentVersionReleaseDate: self.currentVersionReleaseDate,
                   releaseNotes: self.releaseNotes)
    }
}
