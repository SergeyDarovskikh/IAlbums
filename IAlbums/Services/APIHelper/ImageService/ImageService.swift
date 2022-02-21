//
//  SetImage.swift
//  IAlbums
//
//  Created by Сергей Даровских on 10.02.2022.
//

import UIKit

class ImageService {
    
    static let shared = ImageService()
    
    private init() {}
    
    var imageCache = NSCache<NSString, UIImage>()
    var cache = NSCache<NSString, UIImage>()
    
    enum ErrorImageCashe: Error {
        case failDecoding(url: URL)
        case failed(url: URL, error: Error)
    }
    
    private func downloadImage(withURL url: URL, completion: @escaping (Result<UIImage, ErrorImageCashe>) -> Void ) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.failed(url: url, error: error)))
            }
            if let data = data, let image = UIImage(data: data) {
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            } else {
                completion(.failure(.failDecoding(url: url)))
            }
        }.resume()
    }
    
    public func getImage(imageURL: String?, completion: @escaping (UIImage) -> Void ) {
        guard let imageURL = imageURL else {
            completion(UIImage(named: "noImage")!)
            return
        }

        if let image = cache.object(forKey: imageURL as NSString) {
            completion(image)
        } else {
            downloadImage(withURL: URL(string: imageURL)!) { (result) in
                switch result {
                case .success(let image):
                    completion(image)
                case .failure(let error):
                    completion(UIImage(named: "noImage")!)
                    switch error {
                    case .failDecoding(let imageName):
                        print("Error: fail decoding of image. URL: \(imageName)")
                    case .failed(let imageName, let error):
                        print("Error with image. URL: \(imageName) - Error: \(error) ")
                    }
                }
            }
        }
    }
}

