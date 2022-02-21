//
//  AlbumsListViewModel.swift
//  IAlbums
//
//  Created by Сергей Даровских on 20.11.2021.
//

import UIKit

class AlbumsListViewModel {
    var albums = [AlbumModel]()
    
    func fetchAlbums(albumName: String, completion: @escaping (Bool) -> ()) {
        APIManager().getAlbums(name: albumName) { result in
            switch result {
            case .success(let albums):
                if !albums.isEmpty {
                    let sorted = albums.sorted { first, second in
                        return first.collectionName.compare(second.collectionName) == .orderedAscending
                    }
                    self.albums = sorted
                    completion(true)
                } else {
                    self.albums.removeAll()
                    completion(false)
                }
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func getHeightForRow(forIndexPath indexPath: IndexPath) -> CGFloat {
        return AlbumCell.height
    }
    
    func getNumberOfRowsInSections() -> Int {
        return albums.count
    }
    
    func getModelForCell(atIndexPath indexPath: IndexPath) -> AlbumModel? {
        return albums[indexPath.row]
    }
}
