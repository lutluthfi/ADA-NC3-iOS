//
//  StoryModel.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 15/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation


struct StoryModel {
    let title: String
    let isPlayer: Bool
    let player: String
    var options: [StoryOption]? = nil
    var next: Int? = nil
    
    init(title: String, player: String, isPlayer: Bool, options: [StoryOption]? = nil, next: Int? = nil) {
        self.title = title
        self.isPlayer = isPlayer
        self.player = player
        if let options = options {
            self.options = options
        }
        if let next = next {
            self.next = next
        }
    }
    
}
struct StoryOption {
    let title: String
    let direction: Int
}
