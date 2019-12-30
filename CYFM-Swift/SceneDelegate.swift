//
//  SceneDelegate.swift
//  CYFM-Swift
//
//  Created by zcy on 2019/10/12.
//  Copyright © 2019 CY. All rights reserved.
//

import UIKit
import ESTabBarController_swift
import SwiftMessages

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabbarVC = setupTabBarStyle(delegate: self as? UITabBarControllerDelegate)
        window?.windowScene = windowScene
        window?.rootViewController = tabbarVC
        window?.makeKeyAndVisible()
        
    }

    func setupTabBarStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarCont = ESTabBarController()
        tabBarCont.delegate = delegate
        tabBarCont.title = "Irregularity"
        tabBarCont.tabBar.shadowImage = UIImage(named: "tab_transparent")
        tabBarCont.tabBar.backgroundColor = .white

        tabBarCont.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }else {
                return false
            }
        }
        tabBarCont.didHijackHandler = { //  选中凸出item的响应事件
//            [weak tabBarCont] tabbarController, viewController, index in
                tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                CYFMHelperTool.showNoFunctionWarning()
            }
        }
        
        let home = CYFMHomeController()
        let listen = CYFMListenController()
        let play = CYFMPlayController()
        let find = CYFMFindController()
        let mine = CYFMMineController()
        
        home.tabBarItem = ESTabBarItem(CYFMIrregularityBasicContentView(), title: "首页", image: UIImage(named: "tab_home"), selectedImage: UIImage(named: "tab_home_1"), tag: 100)
        home.title = home.tabBarItem.title
        
        listen.tabBarItem = ESTabBarItem(CYFMIrregularityBasicContentView(), title: "我听", image: UIImage(named: "tab_find"), selectedImage: UIImage(named: "tab_find_1"), tag: 101)
        listen.title = listen.tabBarItem.title

        play.tabBarItem = ESTabBarItem(CYFMIrregularityContentView(), title: "播放", image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"), tag: 102)
        find.tabBarItem = ESTabBarItem(CYFMIrregularityBasicContentView(), title: "发现", image: UIImage(named: "tab_favor"), selectedImage: UIImage(named: "tab_favor_1"), tag: 103)
        find.title = find.tabBarItem.title

        mine.tabBarItem = ESTabBarItem(CYFMIrregularityBasicContentView(), title: "我的", image: UIImage(named: "tab_me"), selectedImage: UIImage(named: "tab_me_1"), tag: 104)
        mine.title = mine.tabBarItem.title

        let homeNav = CYFMNavigationController(rootViewController: home)
        let listenNav = CYFMNavigationController(rootViewController: listen)
        let playNav = CYFMNavigationController(rootViewController: play)
        let findNav = CYFMNavigationController(rootViewController: find)
        let mineNav = CYFMNavigationController(rootViewController: mine)
        tabBarCont.viewControllers = [homeNav, listenNav, playNav, findNav, mineNav]

        return tabBarCont
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

