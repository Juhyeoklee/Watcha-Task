//
//  GIFObject.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import UIKit

// MARK: - GIFObject
struct GIFObject {
    var id: String
    var title: String
    var userName: String
    var userDisPlayName: String
    var fixedWidthDownsampledURL: String
    var originalURL: String
    var gifHeight: CGFloat
    
    init() {
        id = ""
        title = ""
        userDisPlayName = ""
        userName = ""
        fixedWidthDownsampledURL = ""
        originalURL = ""
        gifHeight = 0
    }
}
