//
//  ImageDetailViewController.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 06/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit

class ImageDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var viewModel: ImageDetailViewModel

    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ImageDetailViewController.nibName, bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.hero.isEnabled = true
        self.configUI()
    }

    private func configUI() {
        self.imageView.hero.id = "\(ImageCell.baseImageViewHeroId)-\(self.viewModel.unsplashImage.id)"

        if let url = URL(string: self.viewModel.unsplashImage.urlString) {
            self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "imageSearch"))
        } else {
            self.imageView.image = UIImage(named: "imageSearch")
        }

        self.descriptionLabel.text = self.viewModel.unsplashImage.description
        self.dateLabel.text = self.viewModel.unsplashImage.updatedAtString
    }
}
