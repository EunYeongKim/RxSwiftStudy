//
//  SearchAppRepository.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/23.
//

import Foundation
import RxSwift

protocol SearchAppRepositoryProtocol {
	func fetchAppList(request: SearchAppUseCaseRequest, completion: @escaping(Result<[App], APIError>) -> Void)
}

class SearchAppRepository: SearchAppRepositoryProtocol{
	func fetchAppList(request: SearchAppUseCaseRequest, completion: @escaping(Result<[App], APIError>) -> Void) {

		guard var urlComponent = URLComponents(string: Service.APPSTOREAPI) else {
			completion(.failure(.unknown))
			return
		}
		
		urlComponent.queryItems = [
			URLQueryItem(name: "term", value: request.query),
			URLQueryItem(name: "entity", value: "software"),
			URLQueryItem(name: "country", value: "kr"),
			URLQueryItem(name: "limit", value: "200")
		]
		
		guard let url = urlComponent.url else {
			completion(.failure(.unknown))
			return
		}
		
		Service.request(url: url, type: AppStoreDTO.self) { result in
			switch result {
			case .success(let response):
				completion(.success(response.appDTO.map { $0.toEntity() }))
			case .failure(let error):
				completion(.failure(error))
			}
		}
		
	}
}
