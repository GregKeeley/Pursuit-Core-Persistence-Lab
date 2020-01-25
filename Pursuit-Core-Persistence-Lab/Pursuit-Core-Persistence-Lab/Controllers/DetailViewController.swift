//
//  DetailViewController.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/21/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    public var imageData: Hit?
    
    public let dataPersistence = PersistenceHelper()
    
    public var favoriteImages = [Hit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    private func loadData() {
        imageView.getImage(with: imageData?.largeImageURL ?? "https://pixabay.com/get/52e5d24a4a53ab14f6da8c7dda79367a1c3dd9e051586c48702872dc964acd5fbb_1280.jpg") { [weak self] (results) in
            switch results {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(systemName: "exclamationmark-triangle")
                }
                print("Failed to load image: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
        userIDLabel.text = imageData?.user
        likesLabel.text = ("Likes: \(imageData?.likes.description ?? "N/A")")
        tagsLabel.text = ("Tags: \(imageData?.tags ?? "N/A")")
    }
    private func writeToFavorites(image: Hit) {
        favoriteImages.append(image)
        try? dataPersistence
    }
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
    }
    
}
