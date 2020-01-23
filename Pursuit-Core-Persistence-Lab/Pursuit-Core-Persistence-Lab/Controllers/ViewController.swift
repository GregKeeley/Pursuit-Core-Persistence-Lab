//
//  ViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/21/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var imageResults: [Hit]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchResults(searchQuery: "budgerigar")
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        searchBar.layer.cornerRadius = 20
        
    }

    private func loadSearchResults(searchQuery: String) {
        PixaBayAPI.getPhotos(searchQuery: searchQuery) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load search results: \(appError)")
            case .success(let data):
                
                self?.imageResults = data.hits
            }
        }
    }
    
}
extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let squareSize = (collectionView.frame.size.width * 0.95)
        return CGSize(width: squareSize, height: squareSize)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell else {
            fatalError("Failed to dequeue imageCell")
        }
        let hit = imageResults?[indexPath.row]
        cell.layer.cornerRadius = 4
        cell.configureCell(for: hit)
        return cell
    }
}
extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text
        guard !searchText!.isEmpty else {
            loadSearchResults(searchQuery: "squirrel")
            searchBar.resignFirstResponder()
            print("searchText empty")
            return
                }
        loadSearchResults(searchQuery: searchText ?? "squirrel")
      
        searchBar.resignFirstResponder()
        return
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
