//
//  MessageCollectionView.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 12/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class MessageCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.register(MessageCell.self, forCellWithReuseIdentifier: K.CollectionView.messageCellIdentifier)
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
