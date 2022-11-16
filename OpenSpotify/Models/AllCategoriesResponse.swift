//
//  AllCategoriesResponse.swift
//  OpenSpotify
//
//  Created by Mert Duran on 21.09.2022.
//

import Foundation

struct AllCategoriesReponse : Codable {
    let categories : Categories
}

struct Categories : Codable {
    let items : [Category]
}
struct Category : Codable {
    
    let id: String
    let name : String
    let icons : [APIImage]
}
