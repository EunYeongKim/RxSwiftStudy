//
//  DetailViewController.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit
import RxCocoa
import RxSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionDateLabel: UILabel!
    @IBOutlet weak var versionDescriptionLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var app: App?
    var coordinator: DetailViewControllerCoordinator?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let app = app else { return }
        setUpUI(app: app)
    }

    func setUpUI(app: App) {
        Service.loadImage(app.artworkUrl512)
            .observe(on: MainScheduler.instance)
            .bind(to: iconImageView.rx.image)
            .disposed(by: disposeBag)
        iconImageView.setBorderRound(cornerRadius: 10.0)
        
        titleLabel.text = app.trackName
        companyLabel.text = app.sellerName
        versionLabel.text = app.version
        versionDateLabel.text = app.currentVersionReleaseDate.relativeTime()
        versionDescriptionLabel.text = app.releaseNotes ?? ""
        downloadButton.setBorderRound(cornerRadius: 15.0)
        
    
    }
}
