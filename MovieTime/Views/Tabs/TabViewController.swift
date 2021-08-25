//
//  TabViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = Colors.tintColor
        tabBar.isTranslucent = false
        tabBar.barTintColor = Colors.black
        DatabaseManager.shared.getDocuments { movies in
            print("got watchlist")
        }
        setupTabs()
    }
    
    private func setupTabs() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem = UITabBarItem(title: "HOME", image: UIImage(systemName: "house"), tag: 1)
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "SEARCH", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = UITabBarItem(title: "YOU", image: UIImage(systemName: "person.circle"), tag: 2)
        
        viewControllers = [homeVC, searchVC, profileVC]
    }
}

