//
//  ImageCell.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    static let nibName = "ImageCell"
    static let reuseIdentifier = "ImageCellReuseId"
    static let baseImageViewHeroId = "imageViewHeroId"

    var viewModel: ImageCellViewModel! {
        didSet {
            self.config()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.view.layer.cornerRadius = 20;
        self.view.layer.masksToBounds = true;
    }

    private func config() {
        self.imageView.hero.id = "\(ImageCell.baseImageViewHeroId)-\(self.viewModel.unsplashImage.id)"

        if let url = URL(string: self.viewModel.unsplashImage.urlString) {
            self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imageSearch"))
        } else {
            self.imageView.image = UIImage(named: "imageSearch")
        }
        self.descriptionLabel.text = self.viewModel.unsplashImage.description
    }
}
