//
//  AlbumDetailsViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import UIKit

class AlbumDetailsViewModel {
    let album: AlbumModel
    var songsArray: [TrackModel]
    
    init(album: AlbumModel) {
        self.album = album
        self.songsArray = []
    }
    
    func fetchSong(completion: @escaping (Bool) -> ()) {
        let albumId = String(album.collectionId)
        
        APIManager().getTracksInAlbum(albumId: albumId) { result in
            switch result {
            case .success(let songsArray):
                if !songsArray.isEmpty {
                    self.songsArray = songsArray
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let error):
                print(error)
                completion(false)
            }
        }
    }
}
