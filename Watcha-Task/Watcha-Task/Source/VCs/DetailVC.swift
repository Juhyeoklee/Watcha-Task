//
//  DetailVC.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/05.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK:- IBOutlet Variation
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK:- Member Variation
    public var gifData: GIFObject?
    
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func bindData() {
        if let gif = gifData {
            navigationItem.title = gif.title
            if gif.userName.count != 0 {
                displayNameLabel.text = gif.userDisPlayName
                userNameLabel.text = "@" + gif.userName

            }
            else {
                displayNameLabel.text = "Source"
                userNameLabel.text = gif.source
            }
            
            gifImageView.imageFromUrl(gif.originalURL) {
                self.loadingView.stopAnimating()
            }
        }
    }
    
    private func initLayout() {
        if let gif = gifData {
            print(gif.originalHeight, gif.id)
            NSLayoutConstraint.activate([
                gifImageView.heightAnchor.constraint(equalToConstant: gif.originalHeight)
            ])
        }
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.leadingAnchor.constraint(equalTo: gifImageView.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: gifImageView.trailingAnchor),
            loadingView.topAnchor.constraint(equalTo: gifImageView.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: gifImageView.bottomAnchor)
        ])
        
        loadingView.startAnimating()
    }
}
