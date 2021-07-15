//
//  AppListViewModel.swift
//  RxSwiftStudy
//
//  Created by  EUNYEONG on 2021/06/27.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AppListViewModel {
    let VISIBLE_COUNT = 20
    var disposeBag = DisposeBag()
    var totalAppObservable = BehaviorSubject<[App]>(value: [])
    var appObservable = BehaviorRelay<[App]>(value: [])

    func fetchAppList(query: String) {
        guard var urlComponent = URLComponents(string: Service.APPSTOREAPI) else { return }
        urlComponent.queryItems = [
            URLQueryItem(name: "term", value: query),
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "country", value: "kr"),
            URLQueryItem(name: "limit", value: "200")
        ]
        guard let url = urlComponent.url else { return }
        
        Service.fetchData(url: url, type: AppStoreResponse.self)
            .observe(on: MainScheduler.instance)
            .map { return $0.apps }
            .take(1)
            .subscribe(onNext: { [weak self] apps in
                guard let `self` = self else { return }
                self.totalAppObservable.onNext(apps)
                if apps.count > 0 {
                    let endIndex = apps.count < self.VISIBLE_COUNT ? apps.count : self.VISIBLE_COUNT
                    self.appObservable.accept(Array(apps[0 ..< endIndex]))
                }
            })
            .disposed(by: disposeBag)
    }
    
    func getAppList() -> [App] {
        guard let totalApp = try? totalAppObservable.value() else { return [] }
        
        return totalApp
            .enumerated()
            .filter { (index, app) in
                return (appObservable.value.count <= index) && (index < appObservable.value.count + VISIBLE_COUNT)
            }
            .map { (index, app) in
                return app
            }
    }
    
    func prefetchApp(indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last else { return }
        
        if appObservable.value.count - 1 == indexPath.row {
            let appenedApps = appObservable.value + getAppList()
            appObservable.accept(appenedApps)
        }
    }
}
