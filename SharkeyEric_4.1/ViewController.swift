//
//  ViewController.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageCollection: [UIImageView]!
    
    var cellImages: [UIImage] = []
    var iPhoneImages: [[UIImage]] = [[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")],[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")]]
    var selectedImage: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // For loop to add an UITapGestureRecognizer to each imageView and set hte user interaction to true.
        for image in imageCollection{
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(sender:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func imageTapped(sender: UIImageView){
        
    }
}

