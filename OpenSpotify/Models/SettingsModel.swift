//
//  SettingsModel.swift
//  OpenSpotify
//
//  Created by Mert Duran on 12.10.2022.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
