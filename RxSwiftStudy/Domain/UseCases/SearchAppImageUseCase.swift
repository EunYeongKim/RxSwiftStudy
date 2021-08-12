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
			if let image = CacheUtility.shared.imageCache.object(forKey: NSString(string: request.url.absoluteString)) {
				emitter.onNext(image)
				emitter.onCompleted()
			} else {
				self.searchAppImageRepository.fetchImage(request: request) { result in
					switch result {
					case .success(let image):
						CacheUtility.shared.imageCache.setObject(image, forKey: NSString(string: request.url.absoluteString))
						emitter.onNext(image)
						emitter.onCompleted()
					case .failure(let error):
						emitter.onError(error)
					}
				}
			}
			return Disposables.create()
		}
	}
}

struct SearchAppImageUseCaseRequest {
	let url: URL
}
