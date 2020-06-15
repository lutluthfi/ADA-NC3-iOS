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
    private var messageCollectionView: MessageCollectionView!
    private let userOptionsView = OptionsStackView()
    private var gm = GameManager.shared
    private var gameStory = [StoryModel]() {
        willSet {
            if newValue.count > gameStory.count  {
                autoUpdateNextStory(for: newValue.last!)
            }
        }
    }
    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        gameStory = gm.getCurrentStories()
        configureUI()
    }
    
    // MARK: - Helper
    private func configureUI() {
        self.hideNavbar()
        view.backgroundColor = .bgColor
        self.navigationController?.navigationBar.barStyle = .black
        configureOptionsView()
        configureMessageCV()
    }
    
    private func configureOptionsView() {
        view.addSubview(userOptionsView)
        userOptionsView.setAnchor(right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, paddingRight: 10, paddingBottom: 10, paddingLeft: 10)
        userOptionsView.setSize(height: 180)
        configureOptionCells()
        
    }
    
    private func configureMessageCV() {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        
        messageCollectionView = MessageCollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        
        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self
        
        view.addSubview(messageCollectionView)
        messageCollectionView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, bottom: userOptionsView.topAnchor, left: view.leftAnchor, paddingTop: 45, paddingBottom: 30)
    }
    
    private func configureOptionCells() {
        userOptionsView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        guard let options = gameStory.last?.options else {return}
        options.forEach { (opt) in
            let optionButton = OptionButton(type: .system)
            optionButton.optionTitle = opt.title
            optionButton.nextStoryIndex = opt.direction
            optionButton.delegate = self
            
            userOptionsView.addArrangedSubview(optionButton)
        }
    }
    
    private func autoUpdateNextStory(for story: StoryModel) {
        if !gameStory.isEmpty, let nextStory = gm.updateNextStory(from: story){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.gameStory.append(nextStory)
                self.configureOptionCells()
                self.messageCollectionView.reloadData()
                self.messageCollectionView.scrollToItem(at: IndexPath(row: self.gameStory.count - 1, section: 0), at: .centeredVertically, animated: true)
            }
        }
    }

}

// MARK: - Collection View Delegate, Datasource, Flow Layout
extension GameSceneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameStory.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = messageCollectionView.dequeueReusableCell(withReuseIdentifier: K.CollectionView.messageCellIdentifier, for: indexPath) as? MessageCell else{return UICollectionViewCell()}
        
        if indexPath.row != 0 {
            if (gameStory[indexPath.row].player) == (gameStory[indexPath.row - 1].player) && !(gameStory[indexPath.row].isPlayer) {
                cell.isTheSamePlayer = true
            } 
        }
        
        cell.cellData = gameStory[indexPath.row]
       
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = gameStory[indexPath.row].title
        var height = heightForLabel(withText: text)
        
        if !(gameStory[indexPath.row].isPlayer) {
            height += 50
        } else {
            height += 30
        }
              
        return CGSize(width: self.view.frame.width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
}


// MARK: - Option Button Delegate
extension GameSceneViewController: OptionButtonDelegate {
    
    func didSelectButton(nextIndex: Int) {
        let nextStory = gm.setCurrentStories(selectedOptionIndex: nextIndex)
        gameStory.append(nextStory)
        configureOptionCells()
        messageCollectionView.reloadData()
        messageCollectionView.scrollToItem(at: IndexPath(row: self.gameStory.count - 1, section: 0), at: .centeredVertically, animated: true)
    }
    
}
