//
//  GameSceneViewController.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 11/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class GameSceneViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var messageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.register(MessageCell.self, forCellWithReuseIdentifier: K.CollectionView.messageCellIdentifier)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    var player: [[String:Any]] = [
        ["text" : "Lorem ipsum dolor sit amet, consr adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum t labore et magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "isPlayer" : true],
        ["text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, se labore et dolore magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod incididunt utdolore magna aliqua.", "isPlayer" : true],
        ["text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incidiet dolore magna aliqua.", "isPlayer" : true],
        ["text" : "Lorem ipsum dolor sit amet, empor incididunt ut labore et dolore magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum dolor sit amet, consectetueiusmod tempor incididunt ut labore et dolore magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum dolor sit amet, sed do eididunt ut labore et dolore magna aliqua.", "isPlayer" : true],
        ["text" : "Lorem ipsum dolor , consectetur adipiscing elit, sed do eididunt ut labore et dolore magna aliqua.", "isPlayer" : false],
        ["text" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eididunt ut labore et dolore magna aliqua.", "isPlayer" : true],
        ["text" : "Lorem ipsum dolor sit amet, consectetur a aliqua.", "isPlayer" : true],
    ]
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helper
    private func configureUI() {
        self.hideNavbar()
        view.backgroundColor = .white
        configureMessageCV()
    }
    
    private func configureMessageCV() {
        view.addSubview(messageCollectionView)
        messageCollectionView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor)
    }

}

// MARK: - Collection View Delegate, Datasource, Flow Layout
extension GameSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = messageCollectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionView.messageCellIdentifier, for: indexPath) as? MessageCell else{return UICollectionViewCell()}
        
        let text = player[indexPath.row]["text"] as! String
        cell.label.text = text
        
        let isPlayer = player[indexPath.row]["isPlayer"] as! Bool
        cell.isPlayer = isPlayer
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = player[indexPath.row]["text"] as! String
        let height = heightForLabel(withText: text) + 30
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
}
