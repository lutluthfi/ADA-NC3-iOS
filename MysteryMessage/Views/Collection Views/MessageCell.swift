//
//  MessageCell.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 11/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var isTheSamePlayer: Bool = false {
        didSet {
            if isTheSamePlayer {
                self.top = self.topAnchor
                self.avatarView.isHidden = true
            }
        }
    }
    private lazy var top: NSLayoutYAxisAnchor? = nil
    private var senderBox: UIView = {
        let box = UIView()
        box.backgroundColor = .senderBoxColor
        return box
    }()
    private var receiverBox: UIView = {
        let box = UIView()
        box.backgroundColor = .receiverBoxColor
        return box
    }()
    var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .white
        return label
    }()
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Heavy", size: 12)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    var avatarView: UIImageView = {
        let imageView = UIImageView()
        let size: CGFloat = 26
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.setSize(width: size, height: size)
        imageView.configureRoundedCorners(for: [.all], withRadius: size/2)
        return imageView
    }()
    var isPlayer: Bool = false {
        didSet {
            if isPlayer {
                self.addSubview(senderBox)
                senderBox.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingRight: 10, paddingLeft: 80)
                senderBox.configureRoundedCorners(for: [.all], withRadius: 12)
                setLabel(in: senderBox)
            } else {
                self.addSubview(avatarView)
                avatarView.setAnchor(left: self.leftAnchor, paddingLeft: 8)
 
                if self.top == nil {
                    self.addSubview(nameLabel)
                    nameLabel.setAnchor(top: self.topAnchor, right: self.rightAnchor, left: avatarView.rightAnchor, paddingRight: 80, paddingLeft: 12)
                    nameLabel.isHidden = false
                    self.top = nameLabel.bottomAnchor
                }

                self.addSubview(receiverBox)
                receiverBox.setAnchor(top: top!, right: self.rightAnchor, bottom: self.bottomAnchor, left: avatarView.rightAnchor, paddingRight: 80, paddingLeft: 10)
                receiverBox.configureRoundedCorners(for: [.all], withRadius: 12)
                setLabel(in: receiverBox)
                
                avatarView.setCenterYAnchor(in: receiverBox)
            }
        }
    }


    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func setLabel(in view: UIView) {
        view.addSubview(textLabel)
        textLabel.setAnchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingRight: 10, paddingBottom: 10, paddingLeft: 10)
    }
    
}
