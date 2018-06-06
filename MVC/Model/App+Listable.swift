//
//  File.swift
//  MVC
//
//  Created by Gil Nakache on 05/06/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import UIKit

extension App: Listable {
    var image: UIImage? {
        get {
            return thumbImage
        }
        set {
            thumbImage = newValue
        }
    }

    var thumbURL: String {
        return thumbURLString
    }

    func getImage(completion: @escaping (UIImage?) -> Void) {
        var returnImage: UIImage?

        guard let url = URL(string: thumbURLString) else {
            completion(returnImage)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let someData = data {
                returnImage = UIImage(data: someData)
            }
            self.image = returnImage
            DispatchQueue.main.async {
                completion(returnImage)
            }

        }.resume()
    }

    var title: String {
        return name
    }

    var description: String {
        return appDescription
    }
}
