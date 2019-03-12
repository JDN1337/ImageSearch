//
//  UnsplashImageListPresenter.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 12/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import UIKit

protocol UnsplashImageListPresenterDelegate: class {
    func imageListLoaded(_ images: [UnsplashImage])
}

class UnsplashImageListPresenter {
    static var nbItemsByLine = CGFloat(2)

    var images = [UnsplashImage]()
    var emptyLabelText = "Veuillez saisir une recherche..."
    var emptyLabelColor = UIColor.darkGray

    weak var delegate: UnsplashImageListPresenterDelegate?

    func sizeForItem(for collectionView: UICollectionView) -> CGSize {
        let margin = CGFloat(10.0)
        let width = (collectionView.frame.size.width / UnsplashImageListPresenter.nbItemsByLine) - margin

        return CGSize(width: width, height: width)
    }

    func loadImagesWithText(_ searchText: String?, completion: @escaping (Bool) -> Void) {
        UnsplashImageService.loadImagesWithText(searchText) { (images, success) in
            self.images = images

            self.emptyLabelText = success ? "Veuillez saisir une recherche..." : "Erreur lors du chargement des images."
            self.emptyLabelColor = success ? .darkGray : .red

            completion(success)
        }
    }
}
