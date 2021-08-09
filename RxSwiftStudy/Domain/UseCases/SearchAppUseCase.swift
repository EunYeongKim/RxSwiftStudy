//
//  SearchAppUseCase.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/23.
//

import Foundation
import RxSwift

protocol SearchAppUseCaseProtocol {
	func execute(request: SearchAppUseCaseRequest) -> Observable<[App]>
}

class SearchAppUseCase : SearchAppUseCaseProtocol {
	private let searchAppRepository: SearchAppRepository
	
	init(searchAppRepository: SearchAppRepository) {
		self.searchAppRepository = searchAppRepository
	}
	
	func execute(request: SearchAppUseCaseRequest) -> Observable<[App]> {
	
		return Observable<[App]>.create { emitter in
			self.searchAppRepository.fetchAppList(request: request) { result in
				switch result {
				case .success(let apps):
					emitter.onNext(apps)
					emitter.onCompleted()
				case .failure(let error):
					emitter.onError(error)
				}
			}
			return Disposables.create()
		}
	}
}

struct SearchAppUseCaseRequest {
	let query: String
}
