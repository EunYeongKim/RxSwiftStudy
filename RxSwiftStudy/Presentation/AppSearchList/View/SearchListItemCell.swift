//
//  TableViewCell.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/24.
//

import UIKit
import RxCocoa
import RxSwift

class SearchListItemCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var threeImageStackView: UIStackView!
    @IBOutlet weak var oneImageStackView: UIStackView!
   
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var previewImageView1: UIImageView!
    @IBOutlet weak var previewImageView2: UIImageView!
    @IBOutlet weak var previewImageView3: UIImageView!
    
    @IBOutlet weak var downloadBtn: UIButton!
    
    var app: App? {
        didSet {
            guard let app = app else { return }
            let images = [previewImageView1, previewImageView2, previewImageView3]
            
            Service.loadImage(app.artworkUrl512)
                .observe(on: MainScheduler.instance)
                .bind(to: thumbImageView.rx.image)
                .disposed(by: disposeBag)
            thumbImageView.setBorderRound(cornerRadius: 10.0)
            
            titleLabel.text = app.trackName
            descriptionLabel.text = app.description
            downloadBtn.setBorderRound(cornerRadius: 15.0)
            
            for (index, url) in app.screenshotUrls.enumerated() {
                if url.isWidthLongerThanHeight() {
                    threeImageStackView.isHidden = true
                    oneImageStackView.isHidden = false
                    
                    Service.loadImage(url)
                        .observe(on: MainScheduler.instance)
                        .bind(to: previewImageView.rx.image)
                        .disposed(by: disposeBag)
                    previewImageView.setBorderRound(cornerRadius: 10.0)
                    break
                    
                } else {
                    threeImageStackView.isHidden = false
                    oneImageStackView.isHidden = true
                    
                    guard index < images.count , let imageView = images[index] else { return }
                    Service.loadImage(url)
                        .observe(on: MainScheduler.instance)
                        .bind(to: imageView.rx.image)
                        .disposed(by: disposeBag)
                    imageView.setBorderRound(cornerRadius: 10.0)
                }
            }
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        
        thumbImageView.image = nil
        previewImageView1.image = nil
        previewImageView2.image = nil
        previewImageView3.image = nil
        previewImageView.image = nil
    }
}
