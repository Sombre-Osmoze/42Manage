//
//  AppDelegate.swift
//  42Manage
//
//  Created by Marcus Florentin on 14/08/2018.
//  Copyright © 2018 Marcus Florentin. All rights reserved.
//

import UIKit
import API42
import SafariServices
import os.log

var auth : AuthenticationHandler? = nil
var controller : ControllerAPI? = nil

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ControllerAPIDelegate {

	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.

		do {
			controller =  ControllerAPI(token: try Token())
			controller?.delegate = self
			if UserDefaults.standard.value(forKey: "user") == nil {
				throw CachedData.noUser
			}
		} catch  {
			// TODO: Better work here
			os_log(.info, "Can't create session because: %s", error.localizedDescription)
			askAccount()
		}



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
	}


	func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
		print(url)
		return false
	}

	func askAccount() -> Void {
		if window == nil {
			window = UIWindow(frame: UIScreen.main.bounds)
		}

		let loginBoard = UIStoryboard(name: "Login", bundle: nil)

		let initialViewController = loginBoard.instantiateInitialViewController()

		self.window?.rootViewController = initialViewController
		self.window?.makeKeyAndVisible()

	}

	// MARK: - Controller

	func didLogout() {
		DispatchQueue.main.async {
			self.askAccount()
		}
	}

}

