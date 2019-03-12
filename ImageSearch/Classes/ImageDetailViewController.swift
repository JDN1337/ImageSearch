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
    @IBOutlet weak var nbLikesLabel: UILabel!
    @IBOutlet weak var nbLikesHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!

    var presenter: UnsplashImagePresenter

    init(presenter: UnsplashImagePresenter) {
        self.presenter = presenter
        super.init(nibName: ImageDetailViewController.nibName, bundle: Bundle.main)

        self.presenter.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.hero.isEnabled = true
        self.configUI()
    }

    private func configUI() {
        self.imageView.image = self.presenter.defaultImage
        self.presenter.loadImage()

        self.imageView.hero.id = self.presenter.heroId
        self.descriptionLabel.text = self.presenter.description
        self.dateLabel.text = self.presenter.updatedAt
        self.nbLikesLabel.text = self.presenter.nbLikesText
        self.nbLikesHeightConstraint.constant = self.presenter.nbLikesHeight
    }
}

extension ImageDetailViewController: UnsplashImagePresenterDelegate {
    func imageLoaded(_ image: UIImage?) {
        self.imageView.image = image
    }
}
