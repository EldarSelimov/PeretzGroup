//
//  AppDelegate.swift
//  PeretzGroupTest
//
//  Created by Eldar on 14.08.2020.
//  Copyright © 2020 test. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let backImage = UIImage(named: "back-arrow")
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(hexString: "#686868")]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(hexString: "#686868")]
            navBarAppearance.backgroundColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 1)
            
            navBarAppearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
            
            let hideBackButtonTitleAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.clear
            ]
            
            let normalBackButton = navBarAppearance.backButtonAppearance.normal
            let highlightedBackButton = navBarAppearance.backButtonAppearance.highlighted
            
            normalBackButton.titleTextAttributes = hideBackButtonTitleAttributes
            highlightedBackButton.titleTextAttributes = hideBackButtonTitleAttributes
            
            UINavigationBar.appearance().standardAppearance = navBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        } else {
            UINavigationBar.appearance().barTintColor = UIColor(red: 0.092, green: 0.092, blue: 0.092, alpha: 1)
            UINavigationBar.appearance().backIndicatorImage = backImage
            UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
            UIBarButtonItem.appearance().tintColor = .clear
        }
        
        return true
    }
    
    
}
