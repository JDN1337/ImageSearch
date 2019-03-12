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
    var presenter = UnsplashImageListPresenter()

    init() {
        super.init(nibName: ImageSearchViewController.nibName, bundle: Bundle.main)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hero.isEnabled = true

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

        self.presenter.loadImagesWithText(self.searchBar.text) { [weak self] (success) in
            self?.refreshDisplay()
            self?.refreshControl.endRefreshing()
        }
    }

    private func refreshDisplay() {
        self.emptyLabel.text = self.presenter.emptyLabelText
        self.emptyLabel.textColor = self.presenter.emptyLabelColor

        if self.presenter.images.isEmpty {
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
        return self.presenter.sizeForItem(for: collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell {
            cell.presenter = UnsplashImagePresenter(unsplashImage: self.presenter.images[indexPath.item])
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        //Show detailVC
        let presenter = UnsplashImagePresenter(unsplashImage: self.presenter.images[indexPath.item])
        let imageDetailVC = ImageDetailViewController(presenter: presenter)
        self.navigationController?.pushViewController(imageDetailVC, animated: true)
    }
}
