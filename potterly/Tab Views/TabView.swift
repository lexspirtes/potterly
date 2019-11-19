//
//  SecondViewController.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit

class TabController: UITabBarController, UITabBarControllerDelegate {
    let viewModel: TabBarViewModel!
    //defining home VC
    lazy var homeViewController = homeTabStrip(viewModel: viewModel.getHomeViewModel())
        //ButtonBarExampleViewController()
        //homeTabStrip()

    //definine notes
    lazy var notesViewController = NotesView(viewModel: viewModel.getNoteViewModel())
    
    //definine add
    lazy var addViewController = AddCeramicView(viewModel: viewModel.getAddCeramicViewModel())
        
        //AddView(viewModel: viewModel.getAddViewModel())
    
    //defining done
    lazy var doneViewController = DoneStage(viewModel: viewModel.getStageViewModel())
   
    lazy var addNav = UINavigationController(rootViewController: addViewController)
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // creating views as TabBarItem
        homeViewController.tabBarItem = UITabBarItem(title: "home", image: UIImage(named: "home"), tag: 0)
        homeViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)

       // notesViewController.tabBarItem = UITabBarItem(title: "notes", image: UIImage(named: "notesDark"), tag: 1)
//
//        addViewController.tabBarItem = UITabBarItem(title: "add", image: UIImage(named: "addDark"), tag: 2)
//        addViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)

        doneViewController.tabBarItem = UITabBarItem()
        doneViewController.tabBarItem.title = "done"
        doneViewController.tabBarItem.tag = 3
        
        //change colors manually
        doneViewController.tabBarItem.image = UIImage(named: "potunselected")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.selectedImage = UIImage(named: "potsmall")!.withRenderingMode(.alwaysOriginal)
        doneViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        doneViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        //notes
        notesViewController.tabBarItem = UITabBarItem()
        notesViewController.tabBarItem.title = "notes"
        notesViewController.tabBarItem.tag = 1
        notesViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        notesViewController.tabBarItem.image = UIImage(named: "notesUnselected")!.withRenderingMode(.alwaysOriginal)
        notesViewController.tabBarItem.selectedImage = UIImage(named: "notesDark")!.withRenderingMode(.alwaysOriginal)
        notesViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        //add
        addViewController.tabBarItem = UITabBarItem()
        addViewController.tabBarItem.title = "add"
        addViewController.tabBarItem.tag = 3
        addViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
        addViewController.tabBarItem.image = UIImage(named: "addUnselected")!.withRenderingMode(.alwaysOriginal)
        addViewController.tabBarItem.selectedImage = UIImage(named: "addDark")!.withRenderingMode(.alwaysOriginal)
        addViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        //setting viewcontroller list
        let viewControllerList = [ homeViewController,  addViewController, notesViewController, doneViewController]
        viewControllers = viewControllerList
        UITabBar.appearance().barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor.customColors.midnight
        self.tabBar.unselectedItemTintColor = UIColor.customColors.lilac
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor.customColors.lilac.cgColor
        self.delegate = self

    }
    
    //MARK: UITabbar Delegate
    internal func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is AddCeramicView {
            let vc = UINavigationController(rootViewController: AddCeramicView(viewModel: viewModel.getAddCeramicViewModel()))
            vc.modalPresentationStyle = .overFullScreen
            
            //navigation
            vc.navigationBar.isTranslucent = false
              //writing appearance settings
              let navigationBarAppearance = UINavigationBar.appearance()
              if let font = UIFont(name: "Solway-Regular", size: 23) {
                  UINavigationBar.appearance().titleTextAttributes = [
                      NSAttributedString.Key.font: font,
                      NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight,
                      NSAttributedString.Key.kern:CGFloat(3.0)]
              }
              navigationBarAppearance.shadowImage = UIImage()
              
            self.present(vc, animated: true, completion: nil)
            return false
        }
        return true
    }

}

