//
//  NetworkManager.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//
import Foundation

enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
}

struct NetworkManager {

    private let networkRouter = NetworkRouter<URLEndPoint>()
    
    private func handleResult(with result: NetworkCompletion, completion: @escaping(Result<Data, Error>)->Void) {
        if let error = result.error {
            completion(.failure(error))
        }
        if let response = result.response as? HTTPURLResponse {
            let responseResult = handleNetworkResponse(response)
            
            switch responseResult {
            case .success:
                if let data = result.data {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String, NetworkResponse> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.success.rawValue)
        case 401...500: return .failure(NetworkResponse.authenticationError)
        case 501...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.failed)
        }
    }
    
    func getAlbums(name: String, completion: @escaping(Result<Data, Error>)->Void) {
        networkRouter.request(.albums(name: name)) { (result) in
            self.handleResult(with: result, completion: completion)
        }
    }
    
    func getTracksInAlbum(albumId: String, completion: @escaping(Result<Data, Error>)->Void) {
        networkRouter.request(.songsInAlbum(albumId: albumId)) { (result) in
            self.handleResult(with: result, completion: completion)
        }
    }
}
