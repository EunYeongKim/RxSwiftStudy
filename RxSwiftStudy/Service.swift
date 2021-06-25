//
//  Service.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/22.
//

import Foundation
import RxSwift

struct Service {
    static let APPSTOREAPI = "https://itunes.apple.com/search?entity=software&term=Cookie&country=kr&limit=5"
    
    static func loadImage(_ url: String) -> Observable<UIImage?> {
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, _, err) in
                guard err == nil else {
                    emitter.onError(err!)
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
    
    
    static func fetchData<T: Codable>(url: String, type: T.Type) -> Observable<T?> {
        return Observable.create() { emitter in
            let url = URL(string: url)!
            let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard err == nil else {
                    emitter.onError(err!)
                    return
                }
                
                if let data = data, let convertedData = try? JSONDecoder().decode(T.self, from: data) {
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
