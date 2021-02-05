//
//  Analytics.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/06.
//

import Foundation

// MARK: - Analytics
struct Analytics: Codable {
    let onLoad, onClick, onSent: OnURL
}

// MARK: - OnURL
struct OnURL: Codable {
    let url: String
}
