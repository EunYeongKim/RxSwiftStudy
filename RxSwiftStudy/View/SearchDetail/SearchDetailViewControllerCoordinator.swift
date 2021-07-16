//
//  DetailViewControllerCoordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit
import RxSwift

class SearchDetailViewControllerCoordinator: Coordinator {
    
    weak var navigationController: UINavigationController?
    var searchDetailViewModel: SearchDetailViewModel
    
    init(navigationController: UINavigationController, viewModel: SearchDetailViewModel) {
        self.navigationController = navigationController
        self.searchDetailViewModel = viewModel
    }
    
    func start() {
        guard let searchDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchDetailViewController") as? SearchDetailViewController else { return }
        searchDetailVC.coordinator = self
        searchDetailVC.viewModel = self.searchDetailViewModel
        navigationController?.pushViewController(searchDetailVC, animated: true)
    }
}
