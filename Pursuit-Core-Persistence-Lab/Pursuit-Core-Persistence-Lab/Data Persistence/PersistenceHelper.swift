//
//  PersistenceHelper.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/23/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation

enum DataPersistenceError: Error {
    case savingError(Error)
    case fileDoesNotExist(String)
    case noData
    case decodeError(Error)
    case deletingError(Error)
}

class PersistenceHelper {
    
    private static var images = [Hit]()
    private static let filename = "images.plist"
    
    private static func saveFavoriteImages() throws {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        do {
            let data = try PropertyListEncoder().encode(images)
            try data.write(to: url, options: .atomic)
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func createFavoriteImage(image: Hit) throws {
        images.append(image)
        do {
            try saveFavoriteImages()
        } catch {
            throw DataPersistenceError.savingError(error)
        }
    }
    
    static func loadImages() throws -> [Hit] {
        let url = FileManager.pathToDocumentsDirectory(with: filename)
        if FileManager.default.fileExists(atPath: url.path) {
            if let data = FileManager.default.contents(atPath: url.path) {
                do {
                    images = try PropertyListDecoder().decode([Hit].self, from: data)
                } catch {
                    throw DataPersistenceError.decodeError(error)
                }
            } else {
                throw DataPersistenceError.noData
            }
        } else {
            throw DataPersistenceError.fileDoesNotExist(filename)
        }
           return(images)
        }
    
    static func delete(image atIndex: Int) throws {
        images.remove(at: atIndex)
        do {
            try saveFavoriteImages()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
    static func delete(event atIndex: Int) throws {
        images.remove(at: atIndex)
        do {
            try saveFavoriteImages()
        } catch {
            throw DataPersistenceError.deletingError(error)
        }
    }
}

