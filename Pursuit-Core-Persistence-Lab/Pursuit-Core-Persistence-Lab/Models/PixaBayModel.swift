//
//  PixaBayModel.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/21/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

struct PixaBayImage: Codable {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

struct Hit: Codable {
    let largeImageURL: String
    let webformatHeight: Int
    let webformatWidth: Int
    let likes: Int
    let imageWidth: Int
    let id: Int
    let user_id: Int
    let views: Int
    let comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites: Int
    let imageSize: Int
    let previewWidth: Int
    let userImageURL: String
    let previewURL: String
//
//    enum CodingKeys: String, CodingKey {
//        case largeImageURL
//        case webformatHeight
//        case webformatWidth
//        case likes
//        case imageWidth
//        case id
//        case userId = "user_id"
//        case views
//        case comments
//        case pageURL
//        case imageHeight
//        case webformatURL
//        case previewHeight
//        case tags
//        case downloads
//        case user
//        case favorites
//        case imageSize
//        case previewWidth
//        case userImageURL
//        case previewURL
//    }
}
