//
//  OptionCell.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 12/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class OptionButton: UIButton {

    var nextStoryIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .optionViewBgColor
        self.configureRoundedCorners(for: [.all], withRadius: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
