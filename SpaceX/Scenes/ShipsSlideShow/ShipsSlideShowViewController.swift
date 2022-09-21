//
//  ShipsSlideShowViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

class ShipsSlideShowViewController: UIViewController {
    @IBOutlet weak var slideShowCollectionView: UICollectionView!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    
    var presenter: ShipsSlideShowPresenter!
    
    // MARK: - Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupCleanSwift()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCleanSwift()
    }

    // MARK: - Setup

    private func setupCleanSwift() {
        let configurator = ShipsSlideShowConfiguratorImpl()
        configurator.configure(self)
    }
    
    private func setupViews(){
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.delegate = self
        slideShowCollectionView.isPagingEnabled = true
        slideShowCollectionView.showsHorizontalScrollIndicator = false
        slideShowCollectionView.registerNib(class: ShipSlideCell.self)
    }

}


// MARK: UIViewController Lifecycle
extension ShipsSlideShowViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad()
    }
    
}


// MARK: View Protocol Conformation
extension ShipsSlideShowViewController: ShipsSlideShowView {
    
    func reloadList() {
        DispatchQueue.main.async {
            self.slideShowCollectionView.reloadData()
        }
    }
    
}


// MARK: UITableView Delegates
extension ShipsSlideShowViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = presenter.rowIdentifier(at: indexPath)
        let dequeued = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        let cell = dequeued as! ConfigurableCell
        presenter.configure(row: cell, at: indexPath)
        return dequeued
    }
}

extension ShipsSlideShowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.bounds.size.width , height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
