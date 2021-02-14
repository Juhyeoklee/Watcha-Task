//
//  GIFObject.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import UIKit

// MARK: - ImageObject
struct ImageObject {
    var id: String
    var title: String
    var userName: String
    var userDisPlayName: String
    var source: String
    var fixedWidthDownsampledURL: String
    var fixedWidthDownsampledHeight: CGFloat
    var originalURL: String
    var originalHeight: CGFloat
    
    init() {
        id = ""
        title = ""
        userName = ""
        userDisPlayName = ""
        source = ""
        fixedWidthDownsampledURL = ""
        fixedWidthDownsampledHeight = 0
        originalURL = ""
        originalHeight = 0
    }
    
    init(id: String,
         title: String,
         userDisPlayName: String,
         userName: String,
         source: String,
         fixedWidthDownsampledURL: String,
         fixedWidthDownsampledHeight: CGFloat,
         originalURL: String,
         originalHeight: CGFloat) {
        
        self.id = id
        self.title = title
        self.userDisPlayName = userDisPlayName
        self.userName = userName
        self.source = source
        self.fixedWidthDownsampledURL = fixedWidthDownsampledURL
        self.fixedWidthDownsampledHeight = fixedWidthDownsampledHeight
        self.originalURL = originalURL
        self.originalHeight = originalHeight
    }
}
