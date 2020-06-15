//
//  GameManager.swift
//  MysteryMessage
//
//  Created by Muhammad Nobel Shidqi on 12/06/20.
//  Copyright © 2020 Apple Developer Academy. All rights reserved.
//

import Foundation

struct GameManager {
    
    private let story: [StoryModel] = [
        StoryModel(title: "iusmod tempor incididuntolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", player: "Octa", isPlayer: false, options: [
            StoryOption(title: "Option 1", direction: 1),
        ] ),
        StoryModel(title: "Lorem usmod tempor incididunt ut labore et dolore magna aliqua. p ex ea commodo consequat.", player: "User", isPlayer: true, next: 2),
        StoryModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", player: "Octa", isPlayer: false, next: 3),
        StoryModel(title: "Lorem ipsum dout aliquip ex ea commodo consequat.", player: "Ben", isPlayer: false, next: 4),
        StoryModel(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do liquip ex ea commodo consequat.", player: "Ben", isPlayer: false, options: [
            StoryOption(title: "Option 1", direction: 5),
            StoryOption(title: "Option 2", direction: 6),
        ]),
        StoryModel(title: "Lorem ipsum dgna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", player: "User", isPlayer: true, next: 7),
        StoryModel(title: "dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", player: "User", isPlayer: true, next: 7),
        StoryModel(title: "Finish", player: "Vero", isPlayer: false, next: -1),
    ]
    
    static let shared = GameManager()
    private var currentStories = [StoryModel]()
    
    init() {
        guard let firstStory = story.first else {return}
        currentStories.append(firstStory)
    }
    
    mutating func setCurrentStories(selectedOptionIndex optionIndex: Int) -> StoryModel {
        return self.story[optionIndex]
    }
    
    func getCurrentStories() -> [StoryModel] {
        return currentStories
    }
    
    func updateNextStory(from lastStory: StoryModel) -> StoryModel? {
        if let nextStoryIndex = lastStory.next, nextStoryIndex != -1 {
            return self.story[nextStoryIndex]
        }
        return nil
    }
    
}
