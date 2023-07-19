//
//  ShipsSlideShowViewController.swift
//  SpaceX
//
//  Created by Irakli Chkhitunidzde on 20.09.22.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct ShipsSlideShowViewController_Previews: PreviewProvider {
    static var previews: some View {
        UIViewControllerPreview{ ShipsSlideShowViewController() }
    }
}

#endif

class ShipsSlideShowViewController: UIViewController {
    
    // MARK: - Views
    
    private var  bacgroundView: GradientView = {
        let view = GradientView()
        view.matrixRange = 0...5
        view.persent = 4
        view.startColor = .tintColor
        view.endColor = .black
        
        return view
    }()
    
    private var contentView: UIStackView  = {
        let vStack = UIStackView()
        vStack.backgroundColor = .clear
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        return vStack
    }()
    
    private var slideShowCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.registerClass(class: ShipSlideCell.self)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let emptySpace = UIView()
    
    private var speedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Speed: 1.0 X"
        label.textAlignment = .center
        label.textColor = .tintColor
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    private var speedSliderContainer: UIView = UIView()
    
    private var speedSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 1
        slider.minimumValue = 1
        slider.maximumValue = 5
        return slider
    }()
    
    private var controlerButtonsContainer: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.spacing = 40
        return view
    }()
    
    private var restartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        return button
    }()
    
    private var playPauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "play"), for: .normal)
        return button
    }()
    
    private let pageControlSlidesEmptySpace = UIView()
    
    private var pageControler: CustomPageControl = {
        let pageControl = CustomPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.unselectedItemColor =  .gray
        pageControl.selectedItemColor = .tintColor
        
        return pageControl
    }()
    
    // MARK: - Variables
    
    var presenter: ShipsSlideShowPresenter!
    var timer: Timer? = Timer()
    var isPlaying = false
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
        setupCleanSwift()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Actions
    
    @objc func speedSliderValueChange(_ sender: UISlider) {
        speedLabel.text = "Speed: \(String(format: "%.1f", sender.value)) X"
        startTimer(speed: sender.value)
    }
    
    @objc func playPauseButtonTapAction(_ sender: Any) {
        if isPlaying {
            stopTimer()
        } else {
            startTimer(speed: speedSlider.value )
        }
    }
    
    @objc func restartButtonTapAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: {
            self.slideShowCollectionView.contentOffset.x = 0
            self.pageControler.currentPageIndex = 0
        })
        speedLabel.text = "Speed: \(String(format: "%.1f", 1.0)) X"
        if isPlaying { startTimer(speed: 1 ) }
        speedSlider.value = 1.0
    }
    
    // MARK: - Setup
    
    private func setupCleanSwift() {
        let configurator = ShipsSlideShowConfiguratorImpl()
        configurator.configure(self)
    }
    
    private func setUpViews(){
        view = bacgroundView
        
        view.addSubview(contentView)
        contentView.addArrangedSubview(slideShowCollectionView)
        contentView.addArrangedSubview(pageControlSlidesEmptySpace)
        contentView.addArrangedSubview(pageControler)
        contentView.addArrangedSubview(emptySpace)
        contentView.addArrangedSubview(speedLabel)
        contentView.addArrangedSubview(speedSliderContainer)
        speedSliderContainer.addSubview(speedSlider)
        contentView.addArrangedSubview(controlerButtonsContainer)
        
        controlerButtonsContainer.addArrangedSubview(restartButton)
        controlerButtonsContainer.addArrangedSubview(playPauseButton)
        
        
        
        slideShowCollectionView.dataSource = self
        slideShowCollectionView.delegate = self
        
        
        speedSlider.addTarget(self, action: #selector(speedSliderValueChange(_:)), for: .valueChanged)
        restartButton.addTarget(self, action: #selector(restartButtonTapAction(_:)), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapAction(_:)), for: .touchUpInside)
        
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            contentView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            emptySpace.heightAnchor.constraint(equalToConstant: 20),
            pageControlSlidesEmptySpace.heightAnchor.constraint(equalToConstant: 20),
            speedSlider.topAnchor.constraint(equalTo: speedSliderContainer.topAnchor),
            speedSlider.bottomAnchor.constraint(equalTo: speedSliderContainer.bottomAnchor),
            speedSlider.leftAnchor.constraint(equalTo: speedSliderContainer.leftAnchor, constant: 20),
            speedSlider.rightAnchor.constraint(equalTo: speedSliderContainer.rightAnchor, constant: -20),
            controlerButtonsContainer.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}


// MARK: UIViewController Lifecycle
extension ShipsSlideShowViewController {
    
    override func loadView() {
        
        setUpViews()
        setUpConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func alert(text: String) {
        DispatchQueue.main.async { [weak self] in
            self?.openAlert(title: text, message: "", closeButtonTitle: "OK"){}
        }
    }
    
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
        dequeued.gridAnimationCell(indexPath: indexPath)
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
        
        for cell in slideShowCollectionView.visibleCells {
            let indexPath: IndexPath? = slideShowCollectionView.indexPath(for: cell)
            if ((indexPath?.row)!  < presenter.numberOfRows(in: 0) - 1){
                let indexPath1: IndexPath?
                indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                
                slideShowCollectionView.scrollToItem(at: indexPath1!, at: .centeredHorizontally, animated: true)
                pageControler.currentPageIndex = indexPath1!.row
            }
            else{
                let indexPath1: IndexPath?
                indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                slideShowCollectionView.scrollToItem(at: indexPath1!, at: .right, animated: true)
                pageControler.currentPageIndex = indexPath1!.row
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
