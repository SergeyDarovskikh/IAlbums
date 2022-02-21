//
//  TrackModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

struct TrackRequestModel: Decodable, Equatable {
    var results: [TrackModel]
}

struct TrackModel: Decodable, Equatable {
    let trackName: String?
    let trackNumber: Int?
}
