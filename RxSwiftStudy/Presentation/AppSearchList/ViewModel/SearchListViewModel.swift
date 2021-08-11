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

class SearchListViewModel {
    let VISIBLE_COUNT = 20
    var disposeBag = DisposeBag()
    var totalAppObservable = BehaviorSubject<[App]>(value: [])
    var appObservable = BehaviorRelay<[App]>(value: [])
	var showLoading = BehaviorRelay<Bool>(value: false)
	var showPrefetchingLoading = BehaviorRelay<Bool>(value: false)

    func fetchAppList(query: String) {
		showLoading.accept(true)
		
		let usecase = SearchAppUseCase(searchAppRepository: SearchAppRepository())
		let apps = usecase.execute(request: SearchAppUseCaseRequest(query: query))
			
		apps.subscribe(onNext: { [weak self] apps in
			guard let `self` = self else { return }
			self.totalAppObservable.onNext(apps)
			if apps.count > 0 {
				let endIndex = apps.count < self.VISIBLE_COUNT ? apps.count : self.VISIBLE_COUNT
				self.appObservable.accept(Array(apps[0 ..< endIndex]))
				self.showLoading.accept(false)
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
			showPrefetchingLoading.accept(true)
		
            let appenedApps = appObservable.value + getAppList()
			appObservable
				.delay(.seconds(3), scheduler: MainScheduler.instance)
				.take(1)
				.subscribe(onNext: { [weak self] apps in
					guard let `self`  = self else { return }
					self.appObservable.accept(appenedApps)
					self.showPrefetchingLoading.accept(false)
				})
				.disposed(by: disposeBag)
        }
    }
}
