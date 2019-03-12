//
//  UnsplashImagePresenter.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 11/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

protocol UnsplashImagePresenterDelegate: class {
    func imageLoaded(_ image: UIImage?)
}

class UnsplashImagePresenter {
    static let baseImageViewHeroId = "imageViewHeroId"

    let unsplashImage: UnsplashImage
    weak var delegate: UnsplashImagePresenterDelegate?

    init(unsplashImage: UnsplashImage) {
        self.unsplashImage = unsplashImage
    }

    var heroId: String {
        return "\(UnsplashImagePresenter.baseImageViewHeroId)-\(self.unsplashImage.id)"
    }

    var description: String {
        return self.unsplashImage.description
    }

    var nbLikesText: String {
        if self.unsplashImage.nbLikes > 1 {
            return "\(self.unsplashImage.nbLikes) personnes aiment ça"
        } else if self.unsplashImage.nbLikes > 0 {
            return "\(self.unsplashImage.nbLikes) personne aime ça"
        } else {
            return ""
        }
    }

    var nbLikesHeight: CGFloat {
        if self.unsplashImage.nbLikes > 0 {
            return 15.0
        } else {
            return 0.0
        }
    }

    var updatedAt: String {
        if let updatedAt = self.unsplashImage.updatedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            return dateFormatter.string(from: updatedAt)
        } else {
            return ""
        }
    }

    var createdAt: String {
        if let createdAt = self.unsplashImage.createdAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            return dateFormatter.string(from: createdAt)
        } else {
            return ""
        }
    }

    func loadImage() {
        if let url = URL(string: self.unsplashImage.urlString) {
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: [], progress: nil, completed: { (imageLoaded, data, error, finished) in
                if let image = imageLoaded {
                    self.delegate?.imageLoaded(image)
                } else {
                    //Default image
                    self.delegate?.imageLoaded(UIImage(named: "imageSearch"))
                }
            })
        } else {
            //Default image
            self.delegate?.imageLoaded(UIImage(named: "imageSearch"))
        }
    }
}
