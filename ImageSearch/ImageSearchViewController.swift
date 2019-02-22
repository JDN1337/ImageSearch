//
//  ImageSearchViewController.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import UIKit

class ImageSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    var refreshControl = UIRefreshControl()
    var viewModel = ImageSearchViewModel()

    static var nbItemsByLine = CGFloat(2)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: ImageCell.nibName, bundle: nil), forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        //Add pull to refresh
        self.collectionView.alwaysBounceVertical = true
        self.refreshControl.addTarget(self, action: #selector(reloadImages), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)

        self.refreshDisplay()
    }

    @objc func reloadImages() {
        self.collectionView.isHidden = true
        self.emptyLabel.isHidden = true

        self.spinner.startAnimating()
        self.spinner.isHidden = false

        self.viewModel.loadImagesWithText(self.searchBar.text) { [weak self] (success) in
            DispatchQueue.main.async {
                if success {
                    //Reset emptyLabel
                    self?.emptyLabel.text = "Veuillez saisir une recherche..."
                    self?.emptyLabel.textColor = .black
                } else {
                    //Show error on emptyLabel
                    self?.emptyLabel.text = "Erreur lors du chargement des images."
                    self?.emptyLabel.textColor = .red
                }

                self?.refreshDisplay()
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func refreshDisplay() {
        if self.viewModel.images.isEmpty {
            self.collectionView.isHidden = true
            self.emptyLabel.isHidden = false
        } else {
            self.collectionView.isHidden = false
            self.emptyLabel.isHidden = true
        }

        self.spinner.isHidden = true
        self.spinner.stopAnimating()

        self.collectionView.reloadData()
    }
}

extension ImageSearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.reloadImages()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let margin = CGFloat(10.0)
        let width = (collectionView.frame.size.width / ImageSearchViewController.nbItemsByLine) - margin

        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell {
            cell.viewModel = ImageCellViewModel(unsplashImage: self.viewModel.images[indexPath.item])
            return cell
        }

        return UICollectionViewCell()
    }
}
