//
//  URLEndPoint.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

protocol EndPointType {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL { get }
}

enum URLEndPoint {
    case albums(name: String)
    case songsInAlbum(albumId: String)
}

extension URLEndPoint: EndPointType {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .albums:
            return "/search"
        case .songsInAlbum:
            return "/lookup"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .albums(let name):
            return [URLQueryItem(name: "term", value: name),
                    URLQueryItem(name: "entity", value: "album"),
                    URLQueryItem(name: "attribute", value: "albumTerm")]
        case .songsInAlbum(let albumId):
            return [URLQueryItem(name: "id", value: albumId),
                    URLQueryItem(name: "entity", value: "song")]
        }
    }
    
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
    }
}
