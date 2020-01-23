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
    @IBOutlet weak var userImageView: UIImageView!
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.layer.borderWidth = 0.5
        userImageView.layer.cornerRadius = (userImageView.frame.size.width / 2)
        imageView.layer.cornerRadius = 8
    }
    func configureCell(for image: Hit?) {
        imageLabel.text = image?.tags
        imageView.getImage(with: image?.webformatURL ?? "https://cdn.pixabay.com/photo/2016/03/27/17/12/water-1283152_150.jpg") { [weak self] (results) in
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
        userImageView.getImage(with: image?.userImageURL ?? "https://cdn.pixabay.com/user/2016/03/26/22-06-36-459_250x250.jpg") { [weak self] (results) in
            switch results {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.userImageView.image = UIImage(systemName: "xmark.circle")
                }
                print("Failed to load image: \(appError)")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.userImageView.image = image
                }
            }
        }
    }
}
