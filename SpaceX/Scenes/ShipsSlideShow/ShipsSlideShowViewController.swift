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
    @IBOutlet weak var pageControler: CustomPageControl!
    
    var presenter: ShipsSlideShowPresenter!
    var timer: Timer? = Timer()
    var isPlaying = false
    
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
        pageControler.unselectedItemColor =  .gray
        pageControler.selectedItemColor = .blue
        presenter.pageDidChanged = { pageIndex in
            self.pageControler.currentPageIndex = pageIndex
        }
    }
    
    // MARK: Actions
    
    @IBAction func speedSliderValueChange(_ sender: UISlider) {
        speedLabel.text = "Speed: \(String(format: "%.1f", sender.value)) X"
        startTimer(speed: sender.value)
    }
    
    @IBAction func playPauseButtonTapAction(_ sender: Any) {
        if isPlaying {
            stopTimer()
        } else {
            startTimer(speed: speedSlider.value )
        }
    }
    
    @IBAction func restartButtonTapAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
             self.slideShowCollectionView?.contentOffset.x = 0
        })
        speedLabel.text = "Speed: \(String(format: "%.1f", 1.0)) X"
        if isPlaying { startTimer(speed: 1 ) }
        speedSlider.value = 1.0
    }
    
}


// MARK: UIViewController Lifecycle
extension ShipsSlideShowViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let speed = UDManager.shared.getSpeed() < 1.0 ? 1.0 : UDManager.shared.getSpeed()
        
        if isPlaying {
            speedLabel.text = "Speed: \(String(format: "%.1f", speed)) X"
            speedSlider.value = speed
            startTimer(speed: speed)
        }else {
            speedLabel.text = "Speed: \(String(format: "%.1f", speed)) X"
            speedSlider.value = speed
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        stopTimer()
    }
}


// MARK: View Protocol Conformation
extension ShipsSlideShowViewController: ShipsSlideShowView {
    
    func reloadList() {
        DispatchQueue.main.async { [weak self] in
            self?.slideShowCollectionView.reloadData()
            self?.pageControler.numberOfItems = self?.presenter.numberOfRows(in: 0) ?? 0
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didTapItem(at: indexPath)
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / UIScreen.main.bounds.width)
        pageControler.currentPageIndex = index
    }
}

extension ShipsSlideShowViewController {
    
    
    func startTimer(speed: Float) {
        stopTimer()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval( 2.5 / speed), target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        isPlaying = true
        playPauseButton.set(image:UIImage(systemName: "pause"))
    }
    
    @objc func scrollAutomatically(_ timer1: Timer) {
            
            if let coll  = slideShowCollectionView {
                for cell in coll.visibleCells {
                    let indexPath: IndexPath? = coll.indexPath(for: cell)
                    if ((indexPath?.row)!  < presenter.numberOfRows(in: 0) - 1){
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                        
                        coll.scrollToItem(at: indexPath1!, at: .centeredHorizontally, animated: true)
                        pageControler.currentPageIndex = indexPath1!.row
                    }
                    else{
                        let indexPath1: IndexPath?
                        indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                        coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                        pageControler.currentPageIndex = indexPath1!.row
                    }
                    
                }
            }
            
        }
    
    private func stopTimer(){
        timer?.invalidate()
        timer = nil
        isPlaying = false
        playPauseButton.set(image: UIImage(systemName: "play"))
        UDManager.shared.save(speed: speedSlider.value)
    }
}
