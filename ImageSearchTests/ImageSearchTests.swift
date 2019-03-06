//
//  ImageSearchTests.swift
//  ImageSearchTests
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import XCTest
@testable import ImageSearch

import SwiftyJSON

class ImageSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUnsplashImageParser() {
        //Given
        let guessId = "1337"
        let guessUrlString = "https://www.google.com"
        let guessDescription = "Description1234"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let guessCreatedAt = dateFormatter.date(from: "2019-03-04T10:05:24-04:00")
        let guessUpdatedAt = dateFormatter.date(from: "2019-03-06T21:01:02-04:00")

        var jsonDic = [String: Any]()
        jsonDic["id"] = guessId
        jsonDic["urls"] = ["regular" : guessUrlString]
        jsonDic["description"] = guessDescription

        jsonDic["created_at"] = dateFormatter.string(from: guessCreatedAt!)
        jsonDic["updated_at"] = dateFormatter.string(from: guessUpdatedAt!)

        //When
        if let unsplashImage = UnsplashImageParser.parseObject(jsonDic: JSON(jsonDic)) {
            //Then
            XCTAssertEqual(unsplashImage.id, guessId, "Id parsed from UnsplashImageParser is wrong")
            XCTAssertEqual(unsplashImage.urlString, guessUrlString, "UrlString parsed from UnsplashImageParser is wrong")
            XCTAssertEqual(unsplashImage.description, guessDescription, "Description parsed from UnsplashImageParser is wrong")
            XCTAssertEqual(unsplashImage.createdAt, guessCreatedAt, "CreatedAt parsed from UnsplashImageParser is wrong")
            XCTAssertEqual(unsplashImage.updatedAt, guessUpdatedAt, "UpdatedAt parsed from UnsplashImageParser is wrong")
        } else {
            XCTFail("UnsplashImage returned from UnsplashImageParser is nil")
        }
    }

}
