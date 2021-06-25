//
//  TableViewCell.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/06/24.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewCell: UITableViewCell {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var app: App? {
        didSet {
            guard let app = app else { return }
            Service.loadImage(app.artworkUrl512)
                .observe(on: MainScheduler.instance)
                .bind(to: thumbImageView.rx.image)
                .disposed(by: disposeBag)
            titleLabel.text = app.trackName
            genreLabel.text = app.genres[0]
            ratingLabel.text = String(format: "%.2f", app.averageUserRating)
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

}
