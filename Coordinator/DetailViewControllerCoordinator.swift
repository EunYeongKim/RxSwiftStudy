//
//  DetailViewControllerCoordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit

class DetailViewControllerCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    var app: App
    
    init(navigationController: UINavigationController, app: App) {
        self.navigationController = navigationController
        self.app = app
    }
    
    func start() {
        guard let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        detailVC.coordinator = self
        detailVC.app = self.app
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
