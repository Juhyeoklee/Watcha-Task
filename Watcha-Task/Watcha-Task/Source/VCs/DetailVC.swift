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
    
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
    // MARK:- Layout Variation
    lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .black
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK:- Member Variation
    public var gifData: ImageObject!
    public var imageState: ImageState!
    
    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        bindData()
        // Do any additional setup after loading the view.
    }
    
    
    // MARK:- IBAction Method
    @IBAction func touchUpLike(_ sender: UIButton) {
        
        if DataManager.shared.putLike(id: gifData?.id ?? "",
                                      state: imageState) {
            sender.isSelected = !sender.isSelected
        }
    }
    
    // MARK:- Member Method
    private func initLayout() {
        
        heartButton.tintColor = .pointColor
        navigationController?.navigationBar.tintColor = .pointColor
        
        if let gif = gifData {
            imageHeightConstraint.constant = gif.originalHeight < 500 ? gif.originalHeight : 500
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
    
    private func bindData() {
        
        navigationItem.title = gifData.title
        
        if gifData.userName.count != 0 {
            displayNameLabel.text = gifData.userDisPlayName
            userNameLabel.text = "@" + gifData.userName
        }
        else {
            displayNameLabel.text = "Source"
            userNameLabel.text = gifData.source
        }
        
        gifImageView.imageFromUrl(gifData.originalURL) {
            self.loadingView.stopAnimating()
        }
        
        heartButton.isSelected = isLikeImage()
    }
    
    private func isLikeImage() -> Bool {
        return DataManager.shared.isAlreadyLike(id: gifData.id)
    }

}
