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
        //Realm configuration: does necessary migrations
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Pot.className()) { (_, newPot) in
                        newPot?["photo"] = nil
                    }
                }
        })
        
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm(configuration: config)
        //first launch
        
        //tabbar
        let tabBar = TabController(viewModel: TabBarViewModel(NoteData: NoteRealmData(context: realm), CeramicData: CeramicRealmData(context: realm)))
        let navigationController = UINavigationController(rootViewController: tabBar)
        navigationController.navigationBar.isTranslucent = false
        //writing appearance settings
        let navigationBarAppearace = UINavigationBar.appearance()
        if let font = UIFont(name: "SabonLTStd-Bold", size: 28) {
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.font: font,
                NSAttributedString.Key.foregroundColor: UIColor.customColors.midnight,
                NSAttributedString.Key.kern:CGFloat(3.0)]
        }
      //  navigationBarAppearace.barTintColor = UIColor.customColors.lighty
        navigationBarAppearace.shadowImage = UIImage()
        
        //creating window
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController =  navigationController
        window?.makeKeyAndVisible()
        
        //first Launch
        let alwaysFirstLaunch = FirstLaunch.alwaysFirst()
        if alwaysFirstLaunch.isFirstLaunch {
            let vc = PageVC(transitionStyle: .scroll, navigationOrientation: .horizontal)
            vc.modalPresentationStyle = .fullScreen
            navigationController.present(vc, animated: false)
        }

        
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

