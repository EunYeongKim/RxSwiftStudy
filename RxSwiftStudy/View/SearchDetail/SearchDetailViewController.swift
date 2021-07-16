//
//  DetailViewController.swift
//  RxSwiftStudy
//
//  Created by 60080252 on 2021/07/10.
//

import UIKit
import RxCocoa
import RxSwift

class SearchDetailViewController: UIViewController {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionDateLabel: UILabel!
    @IBOutlet weak var versionDescriptionLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: SearchDetailViewModel?
    var coordinator: SearchDetailViewControllerCoordinator?
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard viewModel != nil else { return }
        setUpUI()
    }

    func setUpUI() {
        viewModel?.appObservable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] app in
                guard let `self` = self else { return }
                Service.loadImage(app.artworkUrl512)
                    .observe(on: MainScheduler.instance)
                    .bind(to: self.iconImageView.rx.image)
                    .disposed(by: self.disposeBag)
                self.iconImageView.setBorderRound(cornerRadius: 10.0)

                self.titleLabel.text = app.trackName
                self.companyLabel.text = app.sellerName
                self.versionLabel.text = app.version
                self.versionDateLabel.text = app.currentVersionReleaseDate.relativeTime()
                self.versionDescriptionLabel.text = app.releaseNotes ?? ""
                self.downloadButton.setBorderRound(cornerRadius: 15.0)
            })
            .disposed(by: disposeBag)
    }
}

extension SearchDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.appObservable.value.screenshotUrls.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "screenShotImageCell", for: indexPath) as! ScreenShotImageCell
        let target = viewModel?.appObservable.value.screenshotUrls[indexPath.row]
        cell.imageUrl = target

        return cell
    }
}
