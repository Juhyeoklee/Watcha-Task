//
//  ProfileHeaderCollectionReusableView.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/05.
//

import UIKit

class ProfileHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileHeaderCollectionReusableView"
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var profileNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutInit()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutInit() {
        // ImageView
        self.addSubview(profileImageView)
        NSLayoutConstraint.activate([
            self.profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3),
            self.profileImageView.heightAnchor.constraint(equalTo: self.profileImageView.widthAnchor)
        ])
        
        // Label
        self.addSubview(profileNameLabel)
        NSLayoutConstraint.activate([
            profileNameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 15),
            profileNameLabel.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor)
        ])
    }
}
