//
//  SearchDetailViewModel.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/16.
//

import Foundation
import RxSwift

class SearchDetailViewModel {
    var disposeBag = DisposeBag()
    var appObservable: Observable<App>
    
    init(appObservable: Observable<App>) {
        self.appObservable = appObservable
    }
}
