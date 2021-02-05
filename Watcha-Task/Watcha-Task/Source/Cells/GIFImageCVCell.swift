//
//  GIFImageCVCell.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/04.
//

import UIKit

class GIFImageCVCell: UICollectionViewCell {
    static let identifier = "GIFImageCVCell"
    
    var gifImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        self.addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            gifImageView.topAnchor.constraint(equalTo: self.topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
