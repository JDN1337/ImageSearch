//
//  ImageSearchViewModel.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageSearchViewModel {
    var images = [UnsplashImage]()

    func loadImagesWithText(_ searchText: String?, completion: @escaping (Bool) -> Void) {
        if let searchText = searchText {
            ApiManager.shared.getImagesWithText(searchText) { (data, error, _) in
                self.images.removeAll()

                if let error = error as NSError? {
                    print("GetImagesWithText - Error: \(error.localizedDescription)")
                    completion(false)
                } else if let data = data {
                    do {
                        let json = try JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        self.images = UnsplashImageParser.parseObjects(jsonDic: json["results"])
                        completion(true)
                    } catch {
                        completion(false)
                    }
                } else {
                    completion(false)
                }
            }
        } else {
            completion(true)
        }
    }
}
