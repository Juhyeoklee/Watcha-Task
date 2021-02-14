//
//  UIImageView+Extensions.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/04.
//

import UIKit

import Kingfisher

extension UIImageView {
    public func imageFromUrl(_ urlString: String?) {
        if let url = urlString {
            self.kf.setImage(with: URL(string: url),
                             options: [.transition(ImageTransition.fade(0.5))])
        }
    }
    public func imageFromUrl(_ urlString: String,
                             completionHandler: @escaping () -> ()) {
        
        let cache = ImageCache.default
        cache.retrieveImage(forKey: urlString, options: nil) { (image, _) in
            if let image = image {
                self.image = image
                completionHandler()
            }
            else {
                let url = URL(string: urlString)
                let resource = ImageResource(downloadURL: url!, cacheKey: urlString)
                self.kf.setImage(with: resource,
                                 options: [.transition(ImageTransition.fade(0.5))],
                                 completionHandler:  { _ in
                                    completionHandler()
                                 })
            }
        }
    }
}
