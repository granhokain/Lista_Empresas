//
//  AppDelegate.swift
//  Lista_Empresas
//
//  Created by Rafael Martins on 05/12/19.
//  Copyright © 2019 Rafael Martins. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    var sessionManager: SessionManageable!
    var credentialManager: CredentialManageable!
    let authentcationService = AuthenticationService()
    let container = Container()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupDependencyInjection()
        
        sessionManager = SessionManager()
        credentialManager = CredentialManager()
        checkFirstUse()
        
       // FirebaseApp.configure()
        setupNowPlayingBackground(application)
        
        //IQKeyboardManager.shared.enable = true
        registerForPushNotifications()

//        if let notification = launchOptions?[UIApplication.LaunchOptionsKey.remoteNotification] as? JSONDictionary {
//            let notification = FDCNotification(pushDictionary: notification)
//            startAppCordinator(notification)
//        } else {
//            startAppCordinator()
//        }

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //Messaging.messaging().shouldEstablishDirectChannel = false
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }

    func checkFirstUse() {
        if sessionManager.isFirstUse() {
            credentialManager.removeAll()
        }
    }
    
    func setupNowPlayingBackground(_ application: UIApplication) {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//            try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.moviePlayback)
//        }
//        catch { }
//
//        application.beginReceivingRemoteControlEvents()
    }
}

extension AppDelegate {

    func startAppCordinator() {
//        self.appCoordinator = AppCoordinator(navigationController: BaseNavigationController(), container: container, delegate: nil, notification: notification)
        self.appCoordinator?.start()

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.appCoordinator?.navigationController
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self

        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted, error in
                debugPrint("Permission granted: \(granted)")
                guard granted else { return }
                self?.getNotificationSettings()
        }
    }

    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            debugPrint("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        debugPrint("Device Token: \(token)")

        sessionManager.setNotificationToken(token)
        if sessionManager.isLoggedIn() {
            authentcationService.updateNotificationToken(token: sessionManager.getNotificationToken()){ (message, error, cache) in
                if message != nil {
                    debugPrint(message as Any)
                } else {
                    debugPrint(error?.message as Any)
                }
            }
        }
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("Failed to register: \(error)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)

        completionHandler([UNNotificationPresentationOptions.alert,
                           UNNotificationPresentationOptions.sound,
                           UNNotificationPresentationOptions.badge])
    }

//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo as! JSONDictionary
//
//        let notification = FDCNotification(pushDictionary: userInfo)
//        self.startAppCordinator(notification)
//        completionHandler()
//    }
}

