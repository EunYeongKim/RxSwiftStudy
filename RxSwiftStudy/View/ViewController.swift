//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = AppListViewModel()
    var disposeBag = DisposeBag()
    
    var appstoreResponse: AppStoreResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        searchBar.rx.searchButtonClicked
            .flatMapLatest{ [weak self] _ -> Observable<String> in
                guard let `self` = self, let query = self.searchBar.text else { return .just("") }
                return .just(query)
            }
            .subscribe(onNext: { [weak self] query in
                self?.viewModel.fetchAppList(query: query)
            })

        viewModel.appObservable
            .bind(to: tableView.rx.items(cellIdentifier: "appCell", cellType: TableViewCell.self)) { index, item, cell in
                cell.app = item
            }
            .disposed(by: disposeBag)
    }
}
