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
    
    var iPadImages: [UIImage] = [#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]
    var iPhoneImages: [UIImage] = [#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")]
    var selectedImage: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(imageCollection.count)
        for image in imageCollection{
            image.backgroundColor = UIColor.black
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer){
        print("tapped")
        guard let imageView = sender.view else {return}
        switch selectedImage.count {
        case 0:
            selectedImage.append(imageView.tag)
        //MARK: Show image when clicked.
        case 1:
            selectedImage.append(imageView.tag)
            //MARK: Show images clicked.
            if imageCollection[selectedImage[0]].image == imageCollection[selectedImage[1]].image {
             
                //MARK: Play correct sound.
                for index in selectedImage{
                    imageCollection[index].image = nil
                    imageCollection[index].backgroundColor = UIColor.black
                    imageCollection[index].isUserInteractionEnabled = false
                }
            } else {
                //MARK: Play incorrect sound and flip cards back over.
                print("You suck")
            }
            selectedImage.removeAll()
        default:
            print("Invalid Index")
        }
    }
    
    @IBAction func playButtonSelected(_ sender: UIButton) {
        // For loop to add an UITapGestureRecognizer to each imageView and set the user interaction to true and adding images.
        for image in imageCollection{
            //MARK: Add countdown.

            
            //MARK: Turn play button to a stop button and reset the playing field.
            
            image.backgroundColor = UIColor.cyan
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(sender:)))
            image.isUserInteractionEnabled = true
            
            image.addGestureRecognizer(tap)
            let index = arc4random_uniform(UInt32(iPhoneImages.count))
            
            if iPhoneImages.count == 0{
                image.image = iPadImages[Int(index)]
                iPadImages.remove(at: Int(index))
            } else {
                image.image = iPhoneImages[Int(index)]
                iPhoneImages.remove(at: Int(index))
            }
        }
    }
}

