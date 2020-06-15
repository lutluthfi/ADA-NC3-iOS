//
//  GameStoriesViewController.swift
//  MysteryMessage
//
//  Created by Arif Luthfiansyah on 15/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class GameStoriesViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GameStoriesCollectionViewCell.self, forCellWithReuseIdentifier: GameStoriesCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var lastContentOffset: CGFloat = .zero
    
    private let displayedGameStories: [GameStory] = [
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory")),
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory")),
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory")),
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory")),
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory")),
        .init(title: "Story", description: "Lorem ipsum", poster: #imageLiteral(resourceName: "SamplePosterGameStory"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupViewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setupViewWillDisappear()
    }
    
    private func setupViewDidLoad() {
        self.implementCompontentView()
    }
    
    private func setupViewWillAppear() {
        self.navigationItem.title = "Stories"
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupViewWillDisappear() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func implementCompontentView() {
        self.view.layoutIfNeeded()
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        self.view.layoutIfNeeded()
    }
}

extension GameStoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = GameStoriesCollectionViewCell.height
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = GameStoriesCollectionViewCell.identifier
        let reusableCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? GameStoriesCollectionViewCell
        guard let cell = reusableCell else {
            fatalError()
        }
        let gameStory = self.displayedGameStories[0]
        cell.fill(with: gameStory)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.lastContentOffset < collectionView.contentOffset.y {
            let transformTranslate = CATransform3DTranslate(CATransform3DIdentity, .zero, 64, .zero)
            cell.layer.transform = transformTranslate
            cell.alpha = 0.5
            UIView.animate(withDuration: 0.5) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1
            }
        }
        self.lastContentOffset = collectionView.contentOffset.y
    }
}
