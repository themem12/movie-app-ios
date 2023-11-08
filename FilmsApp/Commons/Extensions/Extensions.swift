//
//  Extensions.swift
//  FilmsApp
//
//  Created by Guillermo Saavedra Dorantes  on 05/11/23.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, placeHolderImage: UIImage) {
        if self.image == nil {
            self.image = placeHolderImage
        }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else { return }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}

extension String {
    public func createImageUrl() -> String {
        return Constant.URL.urlImages + self
    }
}
