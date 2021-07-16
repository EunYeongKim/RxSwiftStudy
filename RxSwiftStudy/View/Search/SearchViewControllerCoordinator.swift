//
//  ViewControllerCoordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit

protocol SearchDetailFlow: class {
    func coordinateToDetail(viewModel: SearchDetailViewModel)
}

class SearchViewControllerCoordinator: Coordinator, SearchDetailFlow {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let searchVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else { return }
        searchVC.coordinator = self
        navigationController.pushViewController(searchVC, animated: true)
    }
    
    func coordinateToDetail(viewModel: SearchDetailViewModel) {
        let searchDetailVCCoordinator = SearchDetailViewControllerCoordinator(navigationController: navigationController, viewModel: viewModel)
        coordinate(to: searchDetailVCCoordinator)
    }
}
