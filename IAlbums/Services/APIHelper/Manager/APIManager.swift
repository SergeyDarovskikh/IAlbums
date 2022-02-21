//
//  APIManager.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

class APIManager {
    
    private let parser = ParserJson()
    private let networkManager = NetworkManager()
    
    public func getAlbums(name: String, completion: @escaping(Result<[AlbumModel], Error>)->Void) {
        networkManager.getAlbums(name: name) { result in
            switch result {
            case .success(let data):
                do {
                    let albumRequestModel = try self.parser.parsingAlbums(data: data)
                    completion(.success(albumRequestModel.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func getTracksInAlbum(albumId: String, completion: @escaping(Result<[TrackModel], Error>)->Void) {
        networkManager.getTracksInAlbum(albumId: albumId) { result in
            switch result {
            case .success(let data):
                do {
                    var trackRequestModel = try self.parser.parsingTracksInAlbum(data: data)
                    trackRequestModel.results.removeFirst()
                    completion(.success(trackRequestModel.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
