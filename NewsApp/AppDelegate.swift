//
//  AppDelegate.swift
//  NewsApp
//
//  Created by jsmirnova on 11.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let appRouter = AppRouter.shared
        appRouter.window = window
        
        appRouter.presentRootModule(animated: true)
        return true
    }
    
}

