//
//  LibraryAlbumsResponse.swift
//  OpenSpotify
//
//  Created by Mert Duran on 10.10.2022.
//

import Foundation

    struct LibraryAlbumsResponse : Codable {
        let items: [SavedAlbum]
    
}

    struct SavedAlbum : Codable {
        
        let added_at: String
        let album: Album
}


