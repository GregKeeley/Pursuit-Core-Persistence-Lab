//
//  PixaBayAPI.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/21/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation
import NetworkHelper

struct PixaBayAPI {
    static func getPhotos(searchQuery: String, completion: @escaping (Result<PixaBayImage, AppError>) -> ()) {
        let pixaBayEndpoint = "https://pixabay.com/api/?key=\(SecretKey.apiKey)&q=\(searchQuery.lowercased())"
        print(pixaBayEndpoint)
        guard let url = URL(string: pixaBayEndpoint) else {
            completion(.failure(.badURL(pixaBayEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (results) in
            switch results {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let results = try JSONDecoder().decode(PixaBayImage.self, from: data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
