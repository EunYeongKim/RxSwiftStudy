//
//  CollectionViewCell.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/14.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var previewImageView: UIImageView!
    
    var imageUrl: String? {
        didSet {
            guard let urlString = imageUrl else { return }
            Service.loadImage(urlString)
                .observe(on: MainScheduler.instance)
                .bind(to: previewImageView.rx.image)
                .disposed(by: disposeBag)
            previewImageView.setBorderRound(cornerRadius: 10.0)
        }
    }
    var disposeBag = DisposeBag()
}
