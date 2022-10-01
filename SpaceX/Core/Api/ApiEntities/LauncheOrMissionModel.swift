//
//  LauncheOrMissionModel.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 02.10.22.
//

import Foundation

// MARK: - LauncheOrMissionModel
struct LauncheOrMissionModel: Codable {
    var flightNumber: Int?
    var missionName: String?
    var launchYear: String?
    var links: Links?
    var details: String?

    enum CodingKeys: String, CodingKey {
        case flightNumber = "flight_number"
        case missionName = "mission_name"
        case launchYear = "launch_year"
        case links, details
    }
}

// MARK: - Links
struct Links: Codable {
    var missionPatch, missionPatchSmall: String?
    var redditCampaign, redditLaunch, redditRecovery, redditMedia: String?
    var presskit: String?
    var articleLink, wikipedia, videoLink: String?
    var youtubeID: String?

    enum CodingKeys: String, CodingKey {
        case missionPatch = "mission_patch"
        case missionPatchSmall = "mission_patch_small"
        case redditCampaign = "reddit_campaign"
        case redditLaunch = "reddit_launch"
        case redditRecovery = "reddit_recovery"
        case redditMedia = "reddit_media"
        case presskit
        case articleLink = "article_link"
        case wikipedia
        case videoLink = "video_link"
        case youtubeID = "youtube_id"
    }
}
