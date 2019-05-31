//
//  SecondViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit

class Downloads: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .blue
        self.title = "home"
//        self.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
//        self.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
//        self.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
    }
}

class Favorites: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .gray
        self.title = "notes"
    }
}

class Bookmarks: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        self.title = "add"
    }
}

class Done: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
        self.title = "done"
    }
}

class logoBanner: UIViewController {
    let color = colors()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = color.darkBlue
        
        self.title = "done"
    }
}

class SecondViewController: UITabBarController {
    let color = colors()
    //defining home VC
    let downloadViewController = Downloads()
    
    //definine notes
    let bookmarkViewController = Bookmarks()
    
    //definine add
    let favoritesViewControllers = Favorites()
    
    //defining done
    let doneViewController = Done()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // creating views as TabBarItems
        downloadViewController.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        downloadViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        downloadViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        bookmarkViewController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "notes"), tag: 1)
        bookmarkViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        bookmarkViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        favoritesViewControllers.tabBarItem = UITabBarItem(title: "add", image: UIImage(named: "add"), tag: 2)
        favoritesViewControllers.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        favoritesViewControllers.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        doneViewController.tabBarItem = UITabBarItem()
        doneViewController.tabBarItem.title = "done"
        doneViewController.tabBarItem.tag = 3
        //doneViewController.tabBarItem.selectedImage = tabBarItem.selectedImage?.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.image = UIImage(named: "potunselected")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.selectedImage = UIImage(named: "potsmall")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        doneViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        let viewControllerList = [ downloadViewController, bookmarkViewController, favoritesViewControllers, doneViewController]
        viewControllers = viewControllerList
        UITabBar.appearance().barTintColor = UIColor.white
        self.tabBar.tintColor = color.darkBlue
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: color.darkBlue], for: .selected)
        self.tabBar.unselectedItemTintColor = color.lightPurple
        self.tabBar.layer.borderWidth = 1
      //  UITabBar.appearance().shadowImage = UIImage(named: "border")
        self.tabBar.layer.borderColor = color.lightPurple.cgColor

//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium" as String, size: 11)], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 11)], for: .selected)
    }


}

