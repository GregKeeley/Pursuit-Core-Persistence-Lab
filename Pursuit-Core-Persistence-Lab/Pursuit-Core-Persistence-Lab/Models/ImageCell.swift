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
    
    func configureCell(for image: PixaBayImage, indexPath: Int) {
        imageLabel.text = image.hits[indexPath].user
        imageView.getImage(with: image.hits[indexPath].previewURL) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print("Failed to load image: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            }
        }
    }
}
