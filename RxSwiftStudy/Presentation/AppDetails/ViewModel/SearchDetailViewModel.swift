//
//  SearchDetailViewModel.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/16.
//

import Foundation
import RxSwift
import RxCocoa

class SearchDetailViewModel {
    var disposeBag = DisposeBag()
    var appObservable: BehaviorRelay<App>
    
    init(appObservable: BehaviorRelay<App>) {
        self.appObservable = appObservable
    }
}
