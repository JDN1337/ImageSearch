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
        image.id = jsonDic["id"].stringValue
        image.urlString = jsonDic["urls"]["regular"].stringValue
        image.description = jsonDic["description"].stringValue
        image.nbLikes = jsonDic["likes"].intValue

        //Dates
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        image.createdAt = dateFormatter.date(from: jsonDic["created_at"].stringValue)
        image.updatedAt = dateFormatter.date(from: jsonDic["updated_at"].stringValue)

        return image
    }
    
}
