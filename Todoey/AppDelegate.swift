//
//  AppDelegate.swift
//  Todoey
//
//  Created by Barthold Albrecht on 16.01.18.
//  Copyright © 2018 Barthold Albrecht. All rights reserved.
//

import UIKit
import RealmSwift



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do {
            _ = try Realm()
            
        } catch {
            print(error)
        }
        
        return true
    }


   
    
   

}


