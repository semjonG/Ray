//
//  TabBarController.swift
//  Ray
//
//  Created by mac on 09.05.2023.
//

import UIKit

final class TabBarController: UITabBarController {
  
  // MARK: Overriden
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupTabBarItems()
  }
  
  func setupViews() {
    view.backgroundColor = .white
  }
  
  // MARK: Private methods
  func setupTabBarItems() {
    let firstItem = UITabBarItem(title: "", image: UIImage(named: "create.png"), tag: 0)
    let firstViewController = CreateImageVC()
    firstViewController.tabBarItem = firstItem
    
    let secondItem = UITabBarItem(title: "", image: UIImage(named: "favorites.png"), tag: 1)
    let secondViewController = FavoritesVC()
    secondViewController.tabBarItem = secondItem
    
    viewControllers = [firstViewController, secondViewController]
  }
}
