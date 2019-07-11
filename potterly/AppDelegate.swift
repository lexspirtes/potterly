//
//  AppDelegate.swift
//  potterly
//
//  Created by Lex Spirtes on 5/28/19.
//  Copyright © 2019 Lex Spirtes. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var navigationController: UINavigationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //realm initialization
        let realm = try! Realm()
        //tabbar
        let tabBar = TabController(viewModel: TabBarViewModel(NoteData: NoteRealmData(context: realm)))
        let navigationController = UINavigationController(rootViewController: tabBar)
        navigationController.navigationBar.isTranslucent = false
        //writing appearance settings
        let navigationBarAppearace = UINavigationBar.appearance()
        if let font = UIFont(name: "SFMono-Medium", size: 20) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight,
                NSAttributedString.Key.kern:CGFloat(2.0)]
        }
        navigationBarAppearace.barTintColor = UIColor.customColors.lighty
        navigationBarAppearace.shadowImage = UIImage()
        
        //creating window
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController =  navigationController
        window?.makeKeyAndVisible()
        
        //jumps up keyboard
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true


        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }


}

