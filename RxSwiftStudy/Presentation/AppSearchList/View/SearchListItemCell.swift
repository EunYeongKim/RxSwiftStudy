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
    
	var disposeBag = DisposeBag()
	
	func bindViewModel(viewModel: SearchListItemViewModel) {
		viewModel.app.subscribe(onNext: { app in
			viewModel.fetchImage(url: app.artworkUrl512)
				.bind(to: self.thumbImageView.rx.image)
				.disposed(by: self.disposeBag)
			self.thumbImageView.setBorderRound(cornerRadius: 10.0)
			
			self.titleLabel.text = app.trackName
			self.descriptionLabel.text = app.description
			self.downloadBtn.setBorderRound(cornerRadius: 15.0)
			
			let images = [self.previewImageView1, self.previewImageView2, self.previewImageView3]
			
			for (index, url) in app.screenshotUrls.enumerated() {
				if url.isWidthLongerThanHeight() {
					self.threeImageStackView.isHidden = true
					self.oneImageStackView.isHidden = false
					
					viewModel.fetchImage(url: url)
						.bind(to: self.previewImageView.rx.image)
						.disposed(by: self.disposeBag)
					self.previewImageView.setBorderRound(cornerRadius: 10.0)
					break
				} else {
					self.threeImageStackView.isHidden = false
					self.oneImageStackView.isHidden = true
					
					guard index < images.count , let imageView = images[index] else { return }
					viewModel.fetchImage(url: url)
						.bind(to: imageView.rx.image)
						.disposed(by: self.disposeBag)
					imageView.setBorderRound(cornerRadius: 10.0)
				}
			}
			
		})
		.disposed(by: disposeBag)
	}
	
    override func prepareForReuse() {
		disposeBag = DisposeBag()
		
        titleLabel.text = ""
        descriptionLabel.text = ""
        
        thumbImageView.image = nil
        previewImageView1.image = nil
        previewImageView2.image = nil
        previewImageView3.image = nil
        previewImageView.image = nil
    }
}
