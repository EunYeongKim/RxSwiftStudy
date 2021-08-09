//
//  SearchAppImageUseCase.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/27.
//

import Foundation
import RxSwift

protocol SearchAppImageUseCaseProtocol {
	func execute(request: SearchAppImageUseCaseRequest) -> Observable<UIImage>
}

class SearchAppImageUseCase : SearchAppImageUseCaseProtocol {
	private let searchAppImageRepository: SearchAppImageRepository
	
	init(searchAppImageRepository: SearchAppImageRepository) {
		self.searchAppImageRepository = searchAppImageRepository
	}
	
	func execute(request: SearchAppImageUseCaseRequest) -> Observable<UIImage> {
	
		return Observable<UIImage>.create { emitter in
			self.searchAppImageRepository.fetchImage(request: request) { result in
				switch result {
				case .success(let image):
					emitter.onNext(image)
					emitter.onCompleted()
				case .failure(let error):
					emitter.onError(error)
				}
			}
			return Disposables.create()
		}
	}
}

struct SearchAppImageUseCaseRequest {
	let url: URL
}
