//
//  AlbumModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

struct AlbumRequestModel: Decodable, Equatable {
    let results: [AlbumModel]
}

struct AlbumModel: Decodable, Equatable {
    let artistName : String
    let trackCount : Int
    let artworkUrl100 : String?
    let collectionName : String
    let releaseDate : String
    let collectionId : Int
}
