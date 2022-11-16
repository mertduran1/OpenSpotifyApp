//
//  RecommendationsResponse.swift
//  OpenSpotify
//
//  Created by Mert Duran on 12.10.2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
