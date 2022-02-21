//
//  ParserJson.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

class ParserJson {
    private func parserJson<TypeDecoder: Decodable>(type: TypeDecoder.Type, data: Data) throws -> TypeDecoder {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(TypeDecoder.self, from: data)
            return data
        } catch {
            throw(error)
        }
    }
}

extension ParserJson {
    func parsingAlbums(data: Data) throws -> AlbumRequestModel {
        do {
            let requestModel: AlbumRequestModel = try parserJson(type: AlbumRequestModel.self, data: data)
            return requestModel
        } catch {
            throw(error)
        }
    }
    
    func parsingTracksInAlbum(data: Data) throws -> TrackRequestModel {
        do {
            let requestModel: TrackRequestModel = try parserJson(type: TrackRequestModel.self, data: data)
            return requestModel
        } catch {
            throw(error)
        }
    }
}
