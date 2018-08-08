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
    @IBOutlet weak var movesLabel: UILabel!
    
    var player = AVAudioPlayer()
    var iPhoneImages: [[UIImage]] = [[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")],[#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]]
    var selectedImage: [Int] = []
    var imageArray: [UIImage] = []
    var numMoves: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        playAudio(resource: "tap", type: "mp3")
        guard let imageView = sender.view else {return}
        
        switch selectedImage.count {
        case 0:
            selectedImage.append(imageView.tag)
            imageView.isUserInteractionEnabled = false
            imageCollection[imageView.tag].image = imageArray[imageView.tag]
        //MARK: Show image when clicked.
        case 1:
            numMoves += 1
            movesLabel.text = "Moves: \(numMoves)"
            imageCollection[imageView.tag].image = imageArray[imageView.tag]
            selectedImage.append(imageView.tag)
            imageView.isUserInteractionEnabled = false
            //MARK: Show image clicked.
            if imageArray[selectedImage[0]] == imageArray[selectedImage[1]] {
                
                playAudio(resource: "correct", type: "wav")
                //MARK: Play correct sound.
                for index in selectedImage{
                    imageCollection[index].backgroundColor = UIColor.black
                    imageCollection[index].image = nil
                }
            } else {
                //MARK: Play incorrect sound and flip cards back over.
                playAudio(resource: "incorrect", type: "wav")
                for index in selectedImage{
                    imageCollection[index].isUserInteractionEnabled = true
                    imageCollection[index].image = nil
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
        if sender.titleLabel?.text == "Play"{
        for image in imageCollection{
            //MARK: Add countdown.
            //MARK: Turn play button to a stop button and reset the playing field.
                
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(sender:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
            
            if iPhoneImages[0].count == 0{
                let index = arc4random_uniform(UInt32(iPhoneImages[1].count))
                image.image = iPhoneImages[1][Int(index)]
                imageArray.append(iPhoneImages[1][Int(index)])
                iPhoneImages[1].remove(at: Int(index))
                
            } else {
                let index = arc4random_uniform(UInt32(iPhoneImages[0].count))
                image.image = iPhoneImages[0][Int(index)]
                imageArray.append(iPhoneImages[0][Int(index)])
                iPhoneImages[0].remove(at: Int(index))
            }
                playAudio(resource: "countdown", type: "wav")
        }
                  sender.setTitle("Stop", for: .normal)
        } else if sender.titleLabel?.text == "Stop"{
            for image in imageCollection{
                image.image = nil
                image.backgroundColor = UIColor.black
            }
            sender.setTitle("Play", for: .normal)
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for image in imageCollection{
            image.image = nil
        }
    }
    
    func playAudio(resource: String, type: String){
        if let path = Bundle.main.path(forResource: resource, ofType: type){
            do{
                let url = URL(fileURLWithPath: path)
                player = try AVAudioPlayer(contentsOf: url)
                
                if resource == "countdown"{
                    player.delegate = self
                }
                player.prepareToPlay()
            } catch{
                print(error.localizedDescription)
            }
            player.play()
        }
    }
}

