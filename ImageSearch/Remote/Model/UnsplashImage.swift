//
//  UnsplashImage.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation

class UnsplashImage {
    var urlString: String
    var description: String

    init(urlString: String = "", description: String = "") {
        self.urlString = urlString
        self.description = description
    }
}
