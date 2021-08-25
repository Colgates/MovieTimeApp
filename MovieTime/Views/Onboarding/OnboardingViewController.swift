//
//  OnboardingViewController.swift
//  MovieTime
//
//  Created by Evgenii Kolgin on 20.07.2021.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OnboardingCollectionViewCell.self, forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        collectionView.backgroundColor = Colors.black
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .systemYellow
        pageControl.pageIndicatorTintColor = .systemGray5
        return pageControl
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        button.backgroundColor = .systemYellow
        button.setTitleColor(Colors.buttonColor, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var slides = [
        OnBoardingSlide(description: "Don't know what movie to watch tonight?", image: OnboardingSlidesImages.slide1),
        OnBoardingSlide(description: "Enjoy our database. Discover new movies.", image: OnboardingSlidesImages.slide2),
        OnBoardingSlide(description: "Save it to your personal watchlist.", image: OnboardingSlidesImages.slide3)
    ]
    
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(skipButton)
        view.addSubview(pageControl)
        view.addSubview(collectionView)
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height * 0.8)
        pageControl.frame = CGRect(x: view.center.x - 100, y: collectionView.frame.size.height + 10, width: 200, height: 44)
        skipButton.frame = CGRect(x: view.center.x - 100, y: pageControl.frame.origin.y + 44, width: 200, height: 44)
    }
    
    @objc private func skipButtonTapped() {
            let vc = TabViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
    }
}

// MARK: - CollectionView Item Size
extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}

// MARK: - CollectionView Data Source
extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(with: slides[indexPath.row])
        return cell
    }
}
