//
//  SceneDelegate.swift
//  DoodleMVVM
//
//  Created by 김동준 on 2022/08/02.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        window.makeKeyAndVisible()
        window.rootViewController = DoodleViewController()
        self.window = window
    }
}

