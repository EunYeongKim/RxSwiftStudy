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
    
    @IBOutlet weak var tableView: UITableView!
    
    var disposeBag = DisposeBag()
    var appstoreResponse: AppStoreResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Service.fetchData(url: Service.APPSTOREAPI, type: AppStoreResponse.self)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] appstoreResponse in
                self?.appstoreResponse = appstoreResponse
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appstoreResponse?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "appCell", for: indexPath) as? TableViewCell else {
            return TableViewCell()
        }
        cell.app = appstoreResponse?.apps[indexPath.row]
        return cell
    }
}
