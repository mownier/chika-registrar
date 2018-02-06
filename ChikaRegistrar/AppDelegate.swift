//
//  AppDelegate.swift
//  ChikaRegistrar
//
//  Created by Mounir Ybanez on 2/6/18.
//  Copyright © 2018 Nir. All rights reserved.
//

import UIKit
import ChikaCore
import FirebaseCommunity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        let scene = Factory().withOutput(output).build()
        let nav = UINavigationController(rootViewController: scene)
        scene.title = "Register"
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }

    func output(_ result: Result<OK>) {
        switch result {
        case .ok(let ok):
            showAlert(withTitle: "Success", message: "\(ok)", from: window!.rootViewController!)
            
        case .err(let error):
            showAlert(withTitle: "Error", message: "\(error)", from: window!.rootViewController!)
        }
    }
    
}

func showAlert(withTitle title: String, message: String, from parent: UIViewController) {
    DispatchQueue.main.async {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        parent.present(alert, animated: true, completion: nil)
    }
}

