//
//  UIStoryboard+Extensions.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/14.
//

import UIKit

extension UIStoryboard {
    
    class var detail: UIStoryboard {
        return UIStoryboard(name: "Detail", bundle: nil)
    }
    
    class var favorites: UIStoryboard {
        return UIStoryboard(name: "Favorites", bundle: nil)
    }
    
    class var search: UIStoryboard {
        return UIStoryboard(name: "Search", bundle: nil)
    }
    
}
