//
//  UnsplashImageParser.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation
import SwiftyJSON

class UnsplashImageParser {

    static func parseObjects(jsonDic: JSON) -> [UnsplashImage] {
        var images = [UnsplashImage]()
        do {
            for dic in jsonDic.arrayValue {
                images.append(try self.images(jsonDic: dic))
            }
        } catch {
            return images
        }

        return images
    }

    static func parseObject(jsonDic: JSON) -> UnsplashImage? {
        do {
            let images = try self.images(jsonDic: jsonDic)
            return images
        } catch {
            return nil
        }
    }

    static func images(jsonDic: JSON) throws -> UnsplashImage {
        let image = UnsplashImage()
        image.urlString = jsonDic["urls"]["regular"].stringValue
        image.description = jsonDic["description"].stringValue
        return image
    }
    
}
