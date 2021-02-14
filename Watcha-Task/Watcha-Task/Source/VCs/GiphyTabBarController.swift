//
//  GiphyTabBarController.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/02.
//

import UIKit

class GiphyTabBarController: UITabBarController {

    // MARK:- LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabs()
    }
    // MARK:- Member Method
    
    private func setTabs() {
        
        guard let searchVC = UIStoryboard
                .search
                .instantiateViewController(identifier: "SearchVC") as? SearchVC else {
            return
        }
        searchVC.title = "Search"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        guard let favoritesVC = UIStoryboard
                .favorites
                .instantiateViewController(identifier: "FavoritesVC") as? FavoritesVC else {
            return
        }
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        self.viewControllers = [searchVC, favoritesVC]
    }

}
