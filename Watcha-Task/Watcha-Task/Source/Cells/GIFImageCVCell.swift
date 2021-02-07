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
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.backgroundColor = .gray
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
        setIndicator(state: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initLayout() {
        addSubview(gifImageView)
        NSLayoutConstraint.activate([
            gifImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            gifImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gifImageView.topAnchor.constraint(equalTo: topAnchor),
            gifImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        addSubview(loadingIndicator)

        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setIndicator(state: Bool) {
        if state {
            gifImageView.backgroundColor = .systemGray5
            loadingIndicator.startAnimating()
        }
        else {
            gifImageView.backgroundColor = .clear
            loadingIndicator.stopAnimating()
        }
    }
    
    public func setImageWithLoading(urlString: String) {
        setIndicator(state: true)
        gifImageView.imageFromUrl(urlString) {
            self.setIndicator(state: false)
        }
    }
}
