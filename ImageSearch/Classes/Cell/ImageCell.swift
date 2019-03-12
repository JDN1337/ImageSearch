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

    var presenter: UnsplashImagePresenter! {
        didSet {
            self.presenter.delegate = self
            self.config()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        self.view.layer.cornerRadius = 20;
        self.view.layer.masksToBounds = true;
    }

    private func config() {
        self.imageView.image = self.presenter.defaultImage
        self.presenter.loadImage()

        self.imageView.hero.id = self.presenter.heroId
        self.descriptionLabel.text = self.presenter.description
    }
}
extension ImageCell: UnsplashImagePresenterDelegate {
    func imageLoaded(_ image: UIImage?) {
        self.imageView.image = image
    }
}
