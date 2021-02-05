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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    // MARK:- Member Method
    private func setTabs() {
        
        guard let searchVC = UIStoryboard(name: "Search", bundle: nil)
                .instantiateViewController(identifier: "SearchVC") as? SearchVC else {
            return
        }
        searchVC.title = "Search"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        guard let favoritesVC = UIStoryboard(name: "Favorites", bundle: nil)
                .instantiateViewController(identifier: "FavoritesVC") as? FavoritesVC else {
            return
        }
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        self.viewControllers = [searchVC, favoritesVC]
    }

}
