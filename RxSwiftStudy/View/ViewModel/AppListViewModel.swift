//
//  AppListViewModel.swift
//  RxSwiftStudy
//
//  Created by  EUNYEONG on 2021/06/27.
//

import Foundation
import RxSwift

class AppListViewModel {
    
    var disposeBag = DisposeBag()
    var appObservable = BehaviorSubject<[App]>(value: [])
    
    func fetchAppList(query: String) {
        guard var urlComponent = URLComponents(string: Service.APPSTOREAPI) else { return }
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr"),
            URLQueryItem(name: "limit", value: "10")
        ]
        guard let url = urlComponent.url else { return }
        
        Service.fetchData(url: url, type: AppStoreResponse.self)
            .observe(on: MainScheduler.instance)
            .map { return $0.apps }
            .take(1)
            .subscribe(onNext: { [weak self] in
                self?.appObservable.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
