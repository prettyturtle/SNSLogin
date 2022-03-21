//
//  AppDelegate.swift
//  SNSLogin
//
//  Created by yc on 2022/03/19.
//

import UIKit
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // MARK: 네이버 로그인
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        instance?.isNaverAppOauthEnable = true // 네이버 앱으로 인증 방식 활성화
        instance?.isInAppOauthEnable = true // SafariViewController로 인증 방식 활성화
        instance?.isOnlyPortraitSupportedInIphone() // 아이폰에서 인증 화면을 세로모드에서만 적용
        
        instance?.serviceUrlScheme = kServiceAppUrlScheme // 미리 만들어두었던 URL Scheme
        instance?.consumerKey = kConsumerKey // 등록한 애플리케이션의 Client ID
        instance?.consumerSecret = kConsumerSecret // 등록한 애플리케이션의 Client Secret
        instance?.appName = kServiceAppName // 앱 이름
        
        return true
    }
    
    // MARK: 네이버 로그인
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance().application(app, open: url, options: options)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

