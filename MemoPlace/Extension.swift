//
//  Extension.swift
//  MemoPlace
//
//  Created by The Bao on 11/14/16.
//  Copyright © 2016 The Bao. All rights reserved.
//

import UIKit

let imageCached = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImageUsingCacheWithURL(imageURL: String){
        self.image = nil 

        // check cache for image first
        if let cachedImage = imageCached.object(forKey: imageURL as AnyObject) {
            self.image = cachedImage as? UIImage
            return
        }
        // otherwise fire new download 
        let url = URL(string: imageURL)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print("Unsolved Error: \(error), \(error?.localizedDescription)")
                return
            }
            DispatchQueue.main.async {
                if let dowloadedImage = UIImage(data: data!) {
                    imageCached.setObject(dowloadedImage, forKey: imageURL as AnyObject)

                    self.image = dowloadedImage 

                }

            }
        }).resume()
    }

}
