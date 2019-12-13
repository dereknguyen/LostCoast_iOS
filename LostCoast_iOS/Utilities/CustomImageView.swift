//
//  CustomImageView.swift
//  LostCoast_iOS
//
//  Created by Derek Nguyen on 9/13/18.
//  Copyright © 2018 Lost Coast Surf Tech. All rights reserved.
//

import UIKit

var imageCache = [String : UIImage]()

class CustomImageView: UIImageView {

    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        self.image = nil
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
        }.resume()
    }

}
