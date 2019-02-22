//
//  ApiManager.swift
//  ImageSearch
//
//  Created by Jordan Lepretre on 22/02/2019.
//  Copyright © 2019 Jordan Lepretre. All rights reserved.
//

import Foundation

class ApiManager {
    static let shared = ApiManager()

    static var baseUrl = "https://api.unsplash.com/search/photos"
    static var apiKey = "&client_id=a76ebbad189e7f2ae725980590e4c520a525e1db029aa4cea87b44383c8a1ec4"

    private init() {
    }

    func getImagesWithText(_ text: String, completion: @escaping ((_ data: Data?, _ error: Error?, _ headers: [AnyHashable: Any]?) -> Void)) {
        let urlString = "\(ApiManager.baseUrl)?query=\(text)\(ApiManager.apiKey)"

        if let requestUrl = URL(string: urlString) {
            self.performRequest(requestUrl: requestUrl) { (data, error, headers) in
                completion(data, error, headers)
            }
        } else {
            completion(nil, NSError(domain: "BAD_REQUEST", code: 400, userInfo: nil), nil)
        }
    }

    private func performRequest(requestUrl: URL, completion: @escaping ((_ data: Data?, _ error: Error?, _ headers: [AnyHashable: Any]?) -> Void)) {

        print("start request - \(requestUrl)")

        let request = URLRequest(url: requestUrl)

        let config = URLSessionConfiguration.default
        config.requestCachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData

        let session = URLSession(configuration: config)

        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            if let httpResponse = response as? HTTPURLResponse {
                print("end request - \(requestUrl)")
                completion(data, error, httpResponse.allHeaderFields)
            } else {
                print("end request - \(requestUrl) - With Error : \(error?.localizedDescription ?? "")")
                completion(data, error, nil)
            }
        }
        task.resume()
    }
}
