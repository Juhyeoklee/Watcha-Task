//
//  GiphyTabBarController.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

class GiphyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabs()
    }
    
    private func setTabs() {
        guard let searchVC = UIStoryboard(name: "Search", bundle: nil)
                .instantiateViewController(identifier: "SearchVC") as? SearchVC else {
            return
        }
        searchVC.title = "Search"
        
        guard let favoritesVC = UIStoryboard(name: "Favorites", bundle: nil)
                .instantiateViewController(identifier: "FavoritesVC") as? FavoritesVC else {
            return
        }
        favoritesVC.title = "Favorites"
        
        self.viewControllers = [searchVC, favoritesVC]
    }

}
