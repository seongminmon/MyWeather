//
//  SceneDelegate.swift
//  MyWeather
//
//  Created by 김성민 on 7/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let vc = MainViewController(view: MainView(), viewModel: MainViewModel())
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
    }
}
