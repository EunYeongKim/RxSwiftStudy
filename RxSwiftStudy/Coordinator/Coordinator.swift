//
//  Coordinator.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
