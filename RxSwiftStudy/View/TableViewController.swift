//
//  ViewController.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class TableViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var coordinator: VCFlow?
    var viewModel = AppListViewModel()
    var disposeBag = DisposeBag()
    
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
                self?.searchBar.endEditing(true)
                self?.viewModel.fetchAppList(query: query)
            })
            .disposed(by: disposeBag)

        viewModel.appObservable
            .bind(to: tableView.rx.items(cellIdentifier: "appCell", cellType: TableViewCell.self)) { index, item, cell in
                cell.app = item
            }
            .disposed(by: disposeBag)
        
        tableView.rx.prefetchRows
            .subscribe(onNext: { [weak self] indexPaths in
                guard let `self` = self else { return }
                self.viewModel.prefetchApp(indexPaths: indexPaths)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(App.self).bind { app in
            self.coordinator?.coordinateToDetail(app: app)
        }.disposed(by: disposeBag)
        
    }
}
