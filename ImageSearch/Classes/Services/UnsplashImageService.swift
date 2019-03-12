//
//  UnsplashImageService.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 12/03/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import SwiftyJSON

class UnsplashImageService {

    static func loadImagesWithText(_ searchText: String?, completion: @escaping ([UnsplashImage], Bool) -> Void) {
        var images = [UnsplashImage]()

        if let searchText = searchText {
            ApiManager.shared.getImagesWithText(searchText) { (data, error, _) in
                if let error = error as NSError? {
                    print("GetImagesWithText - Error: \(error.localizedDescription)")
                    completion(images, false)
                } else if let data = data {
                    do {
                        let json = try JSON(data: data, options: JSONSerialization.ReadingOptions.allowFragments)
                        images = UnsplashImageParser.parseObjects(jsonDic: json["results"])
                        completion(images, true)
                    } catch {
                        completion(images, false)
                    }
                } else {
                    completion(images, false)
                }
            }
        } else {
            completion(images, true)
        }
    }
}
