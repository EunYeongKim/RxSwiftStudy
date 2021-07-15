//
//  Service.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import Foundation
import RxSwift

struct Service {
    static let APPSTOREAPI = "https://itunes.apple.com/search"
    
    static func loadImage(_ url: String) -> Observable<UIImage?> {
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
//                    emitter.onError(err!)
                    return
                }
                
                if let dat = data {
                    let image = UIImage(data: dat)
                    emitter.onNext(image)
                }
                emitter.onCompleted()
            }
            
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    
    static func fetchData<T: Codable>(url: URL, type: T.Type) -> Observable<T> {
        return Observable.create() { emitter in
            let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else {
                    emitter.onError(err!)
                    return
                }
                if let convertedData = try? JSONDecoder().decode(T.self, from: data) {
                    emitter.onNext(convertedData)
                }
                emitter.onCompleted()
            }
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
