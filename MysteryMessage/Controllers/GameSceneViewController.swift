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
    private var gm = GameManager.shared
    private var gameStory = [StoryModel]() {
        willSet {
            if newValue.count > gameStory.count  {
                autoUpdateNextStory(for: newValue.last!)
            }
        }
    }
    private let optionsView = OptionsView()
    private let titleView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        
        let imageView = UIImageView(image: UIImage(systemName: "person.3.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray))
        view.addSubview(imageView)
        imageView.setSize(width: 60, height: 28)
        imageView.setCenterXYAnchor(in: view)
        
        return view
    }()

    
    // MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbar()
        gameStory = gm.getCurrentStories()
        configureUI()
    }
    
    // MARK: - Helper
    private func configureUI() {
        view.backgroundColor = .bgColor
        self.navigationController?.navigationBar.barStyle = .black

        configureOptionsView()
        configureMessageCV()
        configureOptions()

    }
    
    private func configureOptionsView() {
        self.view.addSubview(optionsView)
        optionsView.delegate = self
        optionsView.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)
    }
    
    private func configureMessageCV() {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        
        messageCollectionView = MessageCollectionView(frame: CGRect.zero, collectionViewLayout: flowlayout)
        
        messageCollectionView.delegate = self
        messageCollectionView.dataSource = self
        view.addSubview(messageCollectionView)
        messageCollectionView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.height - 230)
    }
    
    private func configureOptions() {
        if let options = gameStory.last?.options {
            var optButtons = [OptionButton]()
            options.forEach { (option) in
                let optionButton = OptionButton(type: .system)
                optionButton.optionTitle = option.title
                optionButton.nextStoryIndex = option.direction
                optionButton.delegate = self
                optButtons.append(optionButton)
            }
            optionsView.optionButtons = optButtons
        }
    }
    
    private func autoUpdateNextStory(for story: StoryModel) {
        if !gameStory.isEmpty, let nextStory = gm.updateNextStory(from: story){
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.gameStory.append(nextStory)
                self.configureOptions()
                self.messageCollectionView.reloadData()
                self.messageCollectionView.scrollToItem(at: IndexPath(row: self.gameStory.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    private func getCellsHeight() -> CGFloat {
        var cellsHeight: CGFloat = 0
        self.messageCollectionView.subviews.forEach { (subview) in
            cellsHeight += subview.frame.height
        }
        return cellsHeight
    }
    
    private func configureNavbar() {
        navigationItem.titleView = titleView
    
        let topLeftButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(topLeftButtonHandler))
        navigationItem.setLeftBarButton(topLeftButton, animated: true)
    }
    
    // MARK: - Targets
    @objc private func topLeftButtonHandler() {
        print("DEBUG : EXIT")
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

// MARK: - Option View Delegate
extension GameSceneViewController: OptionsViewDelegate {
    
    func didSelectTextFieldForOpen() {
        configureOptions()
        optionsView.textFieldIsOpened = true
        UIView.animate(withDuration: 0.35) {
            self.optionsView.frame.origin.y -= 300
            self.optionsView.frame = CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 300)
            self.messageCollectionView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 380)
            if self.getCellsHeight() > (self.view.frame.height - self.optionsView.frame.height) {
                self.messageCollectionView.frame = self.view.frame.offsetBy(dx: 0, dy: -310)
            }

        }
       
       
    }
    
    func didSelectTextFieldForDismiss() {
        
        optionsView.textFieldIsOpened = false
        UIView.animate(withDuration: 0.35) {
            self.optionsView.frame.origin.y += 300
            self.optionsView.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: self.view.frame.width, height: 100)
            self.messageCollectionView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: self.view.frame.height - 230)
        }
       
    }

}


// MARK: - Option Button Delegate
extension GameSceneViewController: OptionButtonDelegate {
    
    func didSelectButton(nextIndex: Int) {
        let nextStory = gm.setCurrentStories(selectedOptionIndex: nextIndex)
        gameStory.append(nextStory)
        configureOptions()
        messageCollectionView.reloadData()
        messageCollectionView.scrollToItem(at: IndexPath(row: self.gameStory.count - 1, section: 0), at: .centeredVertically, animated: true)
    }
    
}
