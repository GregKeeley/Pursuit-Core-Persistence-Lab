//
//  FavoritesViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/21/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
   @IBOutlet weak var tableView: UITableView!
    
    public var favImages = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadFavImages()
    }
    private func loadFavImages() {
        do {
            favImages = try PersistenceHelper.loadImages()
        } catch {
            print("Error loading favorite iamges: \(error)")
        }
    }
    private func deleteFavImage(indexPath: IndexPath) {
        do {
            try PersistenceHelper.delete(image: indexPath.row)
        } catch {
            print("Error deleting image from favorites: \(error)")
        }
    }

}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favImage",  for: indexPath) as? FavTableViewCell else {
            fatalError("Failed to deque favorite image cell")
        }
        cell.configureCell(for: favImages[indexPath.row])
        return cell
    }
    
    
}
extension FavoritesViewController: UITableViewDelegate {
    
}
