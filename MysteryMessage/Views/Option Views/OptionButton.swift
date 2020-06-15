//
//  OptionCell.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 12/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import UIKit

protocol OptionButtonDelegate {
    func didSelectButton(nextIndex: Int)
}

class OptionButton: UIButton {

    var nextStoryIndex: Int = 0
    var optionTitle: String = "" {
        didSet {
            self.setTitle(optionTitle, for: .normal)
        }
    }
    var delegate: OptionButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .optionViewBgColor
        self.configureRoundedCorners(for: [.all], withRadius: 8)
        self.addTarget(self, action: #selector(optionButtonHandler), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Targets
    @objc private func optionButtonHandler() {
        self.delegate?.didSelectButton(nextIndex: nextStoryIndex)
    }
}
