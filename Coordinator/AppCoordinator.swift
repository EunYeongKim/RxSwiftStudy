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
        
        let tableVCCoordinator = TableViewControllerCoordinator(navigationController: navigationController)
        coordinate(to: tableVCCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
