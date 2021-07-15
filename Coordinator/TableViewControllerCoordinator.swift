//
//  ViewControllerCoordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit

protocol VCFlow: class {
    func coordinateToDetail(app: App)
}

class TableViewControllerCoordinator: Coordinator, VCFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let tableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else { return }
        tableVC.coordinator = self
        navigationController.pushViewController(tableVC, animated: true)
    }
    
    func coordinateToDetail(app: App) {
        let detailVCCoordinator = DetailViewControllerCoordinator(navigationController: navigationController, app: app)
        coordinate(to: detailVCCoordinator)
    }
}
