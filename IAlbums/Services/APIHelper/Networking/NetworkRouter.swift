//
//  NetworkRouter.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import Foundation

public typealias NetworkCompletion = (data: Data?, response: URLResponse?, error: Error?)

class NetworkRouter<EndPoint: EndPointType> {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping (NetworkCompletion) -> Void) {
        let session = URLSession.shared
        task = session.dataTask(with: route.url, completionHandler: { (data, response, error) in
            completion((data, response, error))
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}
