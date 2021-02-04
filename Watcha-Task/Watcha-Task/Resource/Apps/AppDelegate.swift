//
//  AppDelegate.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/01.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var giphyAPIKey = "Xz4WTYAAk0VVwQ8Dh33Qs6x8oCOFXdhO"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UserDefaults.standard.setValue(APIKeys.giphyAPIKey.rawValue,
                                       forKey: UserDefaultKeys.giphyAPIKey.rawValue)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

