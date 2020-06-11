//
//  MessageCell.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 11/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell {
    
    var isPlayer: Bool = false {
        didSet {
            if isPlayer {
                receiverBox.isHidden = true
                setLabel(in: senderBox)
            } else {
                senderBox.isHidden = true
                setLabel(in: receiverBox)
            }
        }
    }
    var senderBox: UIView = {
        let box = UIView()
        box.backgroundColor = .senderBoxColor
        return box
    }()
    var receiverBox: UIView = {
        let box = UIView()
        box.backgroundColor = .receiverBoxColor
        return box
    }()
    var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica", size: 16)
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    private func configureUI() {
        self.addSubview(senderBox)
        senderBox.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 0, paddingRight: 10, paddingBottom: 0, paddingLeft: 50)
        senderBox.configureRoundedCorners(for: [.all], withRadius: 12)
        
        self.addSubview(receiverBox)
        receiverBox.setAnchor(top: self.topAnchor, right: self.rightAnchor, bottom: self.bottomAnchor, left: self.leftAnchor, paddingTop: 0, paddingRight: 50, paddingBottom: 0, paddingLeft: 10)
        receiverBox.configureRoundedCorners(for: [.all], withRadius: 12)
        
    }
    
    func setLabel(in view: UIView) {
        view.addSubview(label)
        label.setAnchor(top: view.topAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, left: view.leftAnchor, paddingTop: 10, paddingRight: 10, paddingBottom: 10, paddingLeft: 10)
    }
    
}
