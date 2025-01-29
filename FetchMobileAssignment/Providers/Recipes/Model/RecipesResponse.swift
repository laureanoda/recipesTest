//
//  RecipesResponse.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/24/25.
//

import Foundation
import Network

struct Recipe: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let cuisine: String
    let name: String
    let photoURLSmall: String?
    let photoURLLarge: String?
    let sourceURL: String?
    let youtubeURL: String?

    private enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

