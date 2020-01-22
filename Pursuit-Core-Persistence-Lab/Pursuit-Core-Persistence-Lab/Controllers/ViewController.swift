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
    
    var searchResults: [Hit]? {
        didSet {

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSearchResults(searchQuery: "Squirrel")
//        collectionView.dataSource = self
//        collectionView.delegate = self
       
    }

    private func loadSearchResults(searchQuery: String) {
        PixaBayAPI.getPhotos(searchQuery: searchQuery) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load search results: \(appError)")
            case .success(let data):
                
                self?.searchResults = data.hits
            }
        }
    }
}
extension ViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath)
        return cell
    }
    
    
}
