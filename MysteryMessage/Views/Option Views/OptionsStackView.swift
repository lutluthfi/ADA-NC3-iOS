//
//  OptionsStackView.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 12/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

class OptionsStackView: UIStackView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.alignment = .fill
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 10
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
