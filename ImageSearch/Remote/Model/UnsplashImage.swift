//
//  UnsplashImage.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation

class UnsplashImage {
    var id = ""
    var urlString = ""
    var description = ""
    var createdAt: Date?
    var updatedAt: Date?
}

extension UnsplashImage {
    var createdAtString: String {
        if let createdAt = self.createdAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            return dateFormatter.string(from: createdAt)
        } else {
            return ""
        }
    }

    var updatedAtString: String {
        if let updatedAt = self.updatedAt {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"

            return dateFormatter.string(from: updatedAt)
        } else {
            return ""
        }
    }
}
