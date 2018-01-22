//
//  AppDelegate.swift
//  VAP-JOBS
//
//  Created by Hoff Silva on 19/01/2018.
//  Copyright © 2018 hoffsilva. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "VAP_JOBS")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        EnvironmentLinks.shared.current = .authenticjobs
        let job = JobsController()
        job.managedContext = coreDataStack.managedContext
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        coreDataStack.saveContext()
    }
}

