//
//  AppDelegate.swift
//  BMovies
//
//  Created by Rodrigo Busata on 05/07/19.
//  Copyright © 2019 Busata. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.registerFatalErrorsLog()
        
        return true
    }

    private func registerFatalErrorsLog() {
        NSSetUncaughtExceptionHandler { (exception) in
            
            print("******************************************************")
            print("FatalError: \(exception)")
            for i in exception.callStackSymbols {
                print("\n\(i)")
            }
            print("******************************************************")
        }
    }
}

