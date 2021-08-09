//
//  SearchListItemViewModel.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/27.
//

import Foundation
import RxSwift
import RxCocoa

class SearchListItemViewModel {
	var app = BehaviorRelay<App>(value: App())
	var useCase = SearchAppImageUseCase(searchAppImageRepository: SearchAppImageRepository())
	
	init(app: App) {
		self.app.accept(app)
	}
	
	func fetchImage(url: String) -> Observable<UIImage> {
		let url = URL(string: url)!
		
		return self.useCase.execute(request: SearchAppImageUseCaseRequest(url: url))
	}
}
