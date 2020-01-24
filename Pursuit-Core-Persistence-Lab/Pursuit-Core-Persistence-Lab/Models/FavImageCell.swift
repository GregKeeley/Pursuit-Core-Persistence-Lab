//
//  FavImageCell.swift
//  Pursuit-Core-Persistence-Lab
//
//  Created by Gregory Keeley on 1/23/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    func configureCell(for image: Hit) {
        userNameLabel.text = image.user
        tagsLabel.text = image.tags
        cellImage.getImage(with: image.previewURL) { [weak self] (results) in
            switch results {
            case .failure(let appError):
                print(appError)
                DispatchQueue.main.async {
                self?.cellImage.image = UIImage(systemName: "xmark.fill")
                }
            case .success(let data):
                DispatchQueue.main.async {
                    self?.cellImage.image = data
                }
            }
        }
    }
    
}
