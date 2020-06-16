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
        StoryModel(title: "Hey, did you see anyone taking out my cookies from the fridge? I left it there yesterday, and now it’s gone.", player: K.PlayerName.D, isPlayer: false, next: 1),
        StoryModel(title: "To tell you the truth, it’s not just my cookies, but also some sandwiches and cakes.", player: K.PlayerName.D, isPlayer: false, next: 2),
        StoryModel(title: "Hey, you’re smart right? I’ve seen your grades, can you help us find out who took our food? I don’t like feeling like I can’t safely use the fridge anymore. I would hate working these long hours without some snacks for my breaks.", player: K.PlayerName.D, isPlayer: false, next: 3),
        StoryModel(title: "Oh, and find my cookies, too, if it’s still out there somewhere.", player: K.PlayerName.D, isPlayer: false, next: 4),
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
