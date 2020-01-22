//
//  ImageCell.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/22/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit
import ImageKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    func configureCell(for image: Hit?) {
        imageLabel.text = image?.user
        imageView.getImage(with: image?.largeImageURL ?? "https://cdn.pixabay.com/photo/2016/03/27/17/12/water-1283152_150.jpg") { [weak self] (results) in
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
    }
}
