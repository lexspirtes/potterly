//
//  SecondViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    let color = colors()
    //defining home VC
    let homeViewController = homeTabStrip()

    //definine notes
    let notesViewController = NotesView()
    
    //definine add
    let addViewController = AddView()
    
    //defining done
    let doneViewController = DoneView()
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // creating views as TabBarItems
        homeViewController.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        homeViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        notesViewController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "notes"), tag: 1)
        notesViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        notesViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        addViewController.tabBarItem = UITabBarItem(title: "add", image: UIImage(named: "add"), tag: 2)
        addViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        addViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        doneViewController.tabBarItem = UITabBarItem()
        doneViewController.tabBarItem.title = "done"
        doneViewController.tabBarItem.tag = 3
        
        //change colors manually
        doneViewController.tabBarItem.image = UIImage(named: "potunselected")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.selectedImage = UIImage(named: "potsmall")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        doneViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        //setting viewcontroller list
        let viewControllerList = [ homeViewController, notesViewController, addViewController, doneViewController]
        viewControllers = viewControllerList
        UITabBar.appearance().barTintColor = UIColor.white
        self.tabBar.tintColor = color.darkBlue
        self.tabBar.unselectedItemTintColor = color.lightPurple
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = color.lightPurple.cgColor
        
        //appearance for title
        self.navigationItem.title = "potterly"
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium" as String, size: 11)], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Montserrat-Medium", size: 11)], for: .selected)
    }


}

