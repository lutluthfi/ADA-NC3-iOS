//
//  MessageCell.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 11/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var isTheSamePlayer: Bool = false
    var cellData: StoryModel = StoryModel(title: "", player: "", isPlayer: false) {
        didSet {
            self.isPlayer = cellData.isPlayer
            self.textLabel.text = cellData.title
            let name = cellData.player
            self.nameLabel.text = name
            self.avatarView.image = UIImage(named: name)
        }
    }
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .white
        return label
    }()
    private lazy var top: NSLayoutYAxisAnchor? = nil
    private var textBox: UIView = {
        let box = UIView()
        box.configureRoundedCorners(for: [.all], withRadius: 12)
        return box
    }()
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    private var avatarView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 23
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.setSize(width: size, height: size)
        imageView.configureRoundedCorners(for: [.all], withRadius: size/2)
        return imageView
    }()
    private var isPlayer: Bool = false {
        didSet {
            if isPlayer {
                configurePlayerUI()
            } else {
                configureReceiverUI()
            }
            self.textBox.addSubview(textLabel)
            textLabel.setAnchor(top: textBox.topAnchor, right: textBox.rightAnchor, bottom: textBox.bottomAnchor, left: textBox.leftAnchor, paddingTop: 8, paddingRight: 8, paddingBottom: 8, paddingLeft: 8)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    }

    
    // MARK: - Helper
    private func configureReceiverUI() {
        resetCell()
        self.addSubview(avatarView)
        avatarView.setAnchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 8, paddingLeft: 8)
        
        self.addSubview(nameLabel)
        nameLabel.setAnchor(top: self.topAnchor, right: self.rightAnchor, left: avatarView.rightAnchor, paddingRight: 80,  paddingLeft: 12)
        self.top = self.nameLabel.bottomAnchor
        self.addSubview(textBox)
        textBox.backgroundColor = .receiverBoxColor
        textBox.setAnchor(top: top!, right: self.rightAnchor, bottom: self.bottomAnchor, left: avatarView.rightAnchor, paddingTop: 3, paddingRight: 80, paddingBottom: 3, paddingLeft: 8)
    }
    
    private func configurePlayerUI() {
        resetCell()
        self.addSubview(textBox)
        textBox.backgroundColor = .senderBoxColor
        textBox.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 3, paddingRight: 8, paddingBottom: 3, paddingLeft: 80)
    }
    
    private func resetCell() {
        self.subviews.forEach { (view) in
            view.removeFromSuperview()
        }
    }
}
