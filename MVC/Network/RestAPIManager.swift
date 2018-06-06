//
//  RestAPIManager.swift
//  ModernMVC
//
//  Created by Gil Nakache on 04/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

class RestApiManager: NSObject {
    typealias ServiceResponse = (Data?, Error?) -> Void

    typealias Payload = [String: Any]

    static func getTopApps(_ onCompletion: @escaping ([App]) -> Void) {
        let baseURL = "https://itunes.apple.com/fr/rss/toppaidapplications/limit=50/json"

        makeHTTPGetRequest(baseURL, onCompletion: {
            data, _ in

            var allApps: [App] = []

            defer {
                onCompletion(allApps)
            }

            guard let data1 = data else {
                return
            }

            guard let json = try? JSONSerialization.jsonObject(with: data1, options: .allowFragments) as? Payload else {
                return
            }

            guard let feed = json?["feed"] as? Payload,
                let apps = feed["entry"] as? [Payload]
            else {
                return
            }

            for app in apps {
                guard let container = app["im:name"] as? Payload,
                    let name = container["label"] as? String,
                    let id = app["id"] as? Payload,
                    let link = id["label"] as? String,
                    let desc = app["summary"] as? Payload,
                    let appDescription = desc["label"] as? String
                else {
                    continue
                }

                guard let imageContainer = app["im:image"] as? [Payload],
                    let imageThumbURLString = imageContainer.first?["label"] as? String else {
                        continue
                }


                let appstoreApp = App()
                appstoreApp.name = name
                appstoreApp.link = link
                appstoreApp.appDescription = appDescription
                appstoreApp.thumbURLString = imageThumbURLString
                
                allApps.append(appstoreApp)
            }
        })
    }

    static func makeHTTPGetRequest(_ path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: URL(string: path)!)

        let session = URLSession.shared

        let task = session.dataTask(with: request as URLRequest) {
            data, _, error in

            DispatchQueue.main.async {
                onCompletion(data, error)
            }
        }

        task.resume()
    }
}
