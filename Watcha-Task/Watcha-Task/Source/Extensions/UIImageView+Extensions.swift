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
            self.kf.setImage(with: URL(string: url), options: [.transition(ImageTransition.fade(0.5))])
        }
    }
}
