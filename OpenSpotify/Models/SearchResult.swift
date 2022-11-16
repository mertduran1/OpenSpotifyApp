//
//  SearchResult.swift
//  OpenSpotify
//
//  Created by Mert Duran on 7.09.2022.
//

import Foundation
enum SearchResult {
    case artist(model: Artist)
    case album(model: Album)
    case track(model: AudioTrack)
    case playlist(model: Playlist)
}
