//
//  ViewController.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    @IBOutlet var imageCollection: [UIImageView]!
    @IBOutlet var viewCollection: [UIView]!
    
    var player = AVAudioPlayer()
    
    var iPadImages: [UIImage] = [#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]
    var iPhoneImages: [UIImage] = [#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")]
    var selectedImage: [Int] = []
    var imageArray: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for view in viewCollection{
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(sender:)))
            view.isUserInteractionEnabled = true
            view.addGestureRecognizer(tap)
            view.backgroundColor = UIColor.cyan
            view.layer.cornerRadius = 10
        }
        
        for image in imageCollection{
            image.backgroundColor = UIColor.cyan
            image.layer.cornerRadius = 10
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
            imageCollection[imageView.tag].isHidden = false
            selectedImage.append(imageView.tag)
            imageView.isUserInteractionEnabled = false
        //MARK: Show image when clicked.
        case 1:
            imageCollection[imageView.tag].isHidden = false
            selectedImage.append(imageView.tag)
            imageView.isUserInteractionEnabled = false
            //MARK: Show image clicked.
            if imageCollection[selectedImage[0]].image == imageCollection[selectedImage[1]].image {
                
                //MARK: Play correct sound.
                for index in selectedImage{
                    viewCollection[index].backgroundColor = UIColor.black
                    imageCollection[index].isHidden = true
                }
            } else {
                //MARK: Play incorrect sound and flip cards back over.
                for index in selectedImage{
                    viewCollection[index].isUserInteractionEnabled = true
                    imageCollection[index].isHidden = true
                }
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
            
            let index = arc4random_uniform(UInt32(iPhoneImages.count))
            
            if iPhoneImages.count == 0{
                image.image = iPadImages[Int(index)]
                imageArray.append(iPadImages[Int(index)])
                iPadImages.remove(at: Int(index))
                
            } else {
                image.image = iPhoneImages[Int(index)]
                imageArray.append(iPhoneImages[Int(index)])
                iPhoneImages.remove(at: Int(index))
            }
        }
        playAudio()
        
    }
    
    func playAudio(){
        if let path = Bundle.main.path(forResource: "countdown", ofType: "wav"){
            do{
                let url = URL(fileURLWithPath: path)
                player = try AVAudioPlayer(contentsOf: url)
                player.delegate = self
                player.prepareToPlay()
            } catch{
                print(error.localizedDescription)
            }
            
            player.play()
            
        }
        
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("What")
        for image in imageCollection{
            image.isHidden = true
        }
    }
}

