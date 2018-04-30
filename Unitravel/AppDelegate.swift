//
//  AppDelegate.swift
//  Unitravel
//
//  Created by Abraham Rubio on 5/25/17.
//  Copyright © 2017 UPQ. All rights reserved.
//

import UIKit
import Parse
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var storyboard: UIStoryboard?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        let configuration = ParseClientConfiguration {
            $0.applicationId = "0eFkLi8Mw1YgAfXxAgTMNlNTY7w44w2yqY2tBPby"
            $0.clientKey = "sFdLer40JXSuB69Mm1UahPDih5DUD7NxJWZynIHL"
            $0.server = "https://parseapi.back4app.com/"
            $0.isLocalDatastoreEnabled = true
        }
        
        Parse.initialize(with: configuration)
        
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let user = PFUser.current()
        if user != nil{
            if let role = user?["rol"] as? String{
                self.window?.rootViewController = role == "Student" ? self.storyboard?.instantiateViewController(withIdentifier: "studentLog") : self.storyboard?.instantiateViewController(withIdentifier: "log")
            }
            
        }
        
        //UINavigationBar.appearance().barTintColor = UIColor(red:0.23, green:0.32, blue:0.71, alpha:1.0)
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.23, green: 0.32, blue:0.71, alpha:1.0)
       
        
        UINavigationBar.appearance().tintColor = UIColor.white
        
        UINavigationBar.appearance().tintColor = UIColor.white
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        UIApplication.shared.statusBarStyle = .lightContent
        
        let emptyImage = UIImage()
        UINavigationBar.appearance().shadowImage = emptyImage
        UINavigationBar.appearance().setBackgroundImage(emptyImage, for: .default)

//        let barAppearace = UIBarButtonItem.appearance()
//        barAppearace.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken as Data)
        installation?.saveInBackground()
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
    }


}

