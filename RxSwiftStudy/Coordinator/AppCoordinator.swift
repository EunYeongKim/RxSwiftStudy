//
//  AppCoordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let searchVCCoordinator = SearchViewControllerCoordinator(navigationController: navigationController)
        coordinate(to: searchVCCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
