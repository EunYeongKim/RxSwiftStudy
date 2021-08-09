//
//  SearchAppImageRepository.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/27.
//

import Foundation
import UIKit

protocol SearchAppImageRepositoryProtocol {
	func fetchImage(request: SearchAppImageUseCaseRequest, completion: @escaping(Result<UIImage, APIError>) -> Void)
}

class SearchAppImageRepository: SearchAppImageRepositoryProtocol {
	func fetchImage(request: SearchAppImageUseCaseRequest, completion: @escaping (Result<UIImage, APIError>) -> Void) {
		
		Service.requestData(url: request.url, type: Data.self) { result in
			switch result {
			case .success(let response):
				guard let image = UIImage(data: response) else {
					completion(.failure(.dataNil))
					return
				}
				completion(.success(image))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
