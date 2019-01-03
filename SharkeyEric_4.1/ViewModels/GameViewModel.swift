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
    
    // Computed property to return the numImages based on device type.
    var numImages: Int? {
        // Checking the current device and setting the numImages variable accordingly.
        var numImages: Int?
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            numImages = 19
        case .pad:
            numImages = 29
        default:
            print("Device Unsepecified.")
        }
        return numImages
    }
    
    
    // Function to return an array of Cards.
    func intialSetUp(cards: [Card]){
        
        if var num = numImages {
            
            while num >= 0 {
            
                
                
                num -= 1
            }
        }
    }
}
