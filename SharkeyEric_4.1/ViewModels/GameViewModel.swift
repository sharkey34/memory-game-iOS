//
//  GameViewModel.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 1/1/19.
//  Copyright © 2019 Eric Sharkey. All rights reserved.
//

import Foundation
import UIKit

class GameViewModel{
    
    private var iPhoneImages: [UIImage] = [#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")]
    private var iPadImages: [UIImage] = [#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]
    
    // TODO: Move the logic from the GameViewController to here.
    // TODO: Expose neceassry functions to be used by GameViewController.
    
    
    // TODO: Function to accept the number of cards needed assign the values and return an array of cards.
    
    
    // Property to return an array of Cards.
    var imageArray: [UIImage]? {
        // TOOD: Works setting the images of the cards from here need to add collection of cards and retain it.
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return iPhoneImages.shuffled()
        case .pad:
            return iPadImages.shuffled()
        default:
            print("Device Unsepecified.")
            return nil
        }
    }
}
