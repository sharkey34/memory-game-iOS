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
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var movesTextLabel: UILabel!
    @IBOutlet weak var timeAmountLabel: UILabel!
    @IBOutlet weak var numMovesLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet var iPhoneCollection: [UIImageView]!
    @IBOutlet weak var timerLabel: UILabel!
    
    var player = AVAudioPlayer()
    var iPhoneImages: [[UIImage]] = [[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")],[#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]]
    var images: [[UIImage]] = [[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")],[#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino dice"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "casino token"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals blue stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "minerals red stone"),#imageLiteral(resourceName: "music microphone"),#imageLiteral(resourceName: "music microphone")]]
    var selectedImage: [Int] = []
    var imageArray: [UIImage] = []
    var numMoves: Int = 0
    var device = ""
    var numImages = 0
    var timer = Timer()
    var timeSeconds = 0
    var timeMinutes = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            device = "phone"
            numImages = 19
        case .pad:
            device = "pad"
            numImages = 29
        default:
            print("Device Unsepecified.")
        }
        
        
        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
        winLabel.text = ""
        movesTextLabel.text = ""
        timeAmountLabel.text = ""
        numMovesLabel.text = ""
        timeLabel.text = ""
        movesLabel.text = ""
        timerLabel.text = ""
        
        for image in iPhoneCollection[...numImages]{
            image.backgroundColor = UIColor.black
            image.layer.cornerRadius = 10
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @objc func imageTapped(sender: UITapGestureRecognizer){
        
        
        guard let imageView = sender.view as? UIImageView else {return}
        
        if imageView.image == nil{
            playAudio(resource: "tap", type: "mp3")
            
            switch selectedImage.count {
            case 0:
                selectedImage.append(imageView.tag)
                imageView.isUserInteractionEnabled = false
                iPhoneCollection[imageView.tag].image = imageArray[imageView.tag]
            case 1:
                numMoves += 1
                movesLabel.text = "Moves: \(numMoves)"
                selectedImage.append(imageView.tag)
                imageView.isUserInteractionEnabled = false
                iPhoneCollection[imageView.tag].image = imageArray[imageView.tag]
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    if self.imageArray[self.selectedImage[0]] == self.imageArray[self.selectedImage[1]] {
                        self.playAudio(resource: "correct", type: "wav")
                        for index in self.selectedImage{
                            self.iPhoneCollection[index].backgroundColor = UIColor.black
                            self.iPhoneCollection[index].image = nil
                        }
                        self.alert()
                    } else {
                        self.playAudio(resource: "incorrect", type: "wav")
                        for index in self.selectedImage{
                            self.iPhoneCollection[index].isUserInteractionEnabled = true
                            self.iPhoneCollection[index].image = nil
                        }
                        print("You suck")
                    }
                    self.selectedImage.removeAll()
                    
                }
            default:
                print("Invalid Index")
            }
        } else {
            print("cards flipped")
        }
        
    }

    @IBAction func playButtonSelected(_ sender: UIButton) {
        winLabel.text = ""
        movesTextLabel.text = ""
        numMovesLabel.text = ""
        timeLabel.text = ""
        timeAmountLabel.text = ""
        // For loop to add an UITapGestureRecognizer to each imageView and set the user interaction to true and adding images
        
        if sender.titleLabel?.text == "Play"{
            if timer.isValid == false{
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            }
        for image in iPhoneCollection{
            image.backgroundColor = UIColor.cyan
            //MARK: Add countdown.
            //MARK: Turn play button to a stop button and reset the playing field.
                
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.imageTapped(sender:)))
            image.isUserInteractionEnabled = true
            image.addGestureRecognizer(tap)
            
            //MARK: Instead of using the array of arrays of images then 
            if iPhoneImages[0].count == 0{
                let index = arc4random_uniform(UInt32(iPhoneImages[1].count))
                image.image = iPhoneImages[1][Int(index)]
                imageArray.append(iPhoneImages[1][Int(index)])
                iPhoneImages[1].remove(at: Int(index))
                
            } else {
                let index = arc4random_uniform(UInt32(iPhoneImages[0].count))
                image.image = iPhoneImages[0][Int(index)]
                imageArray.append(image.image!)
                iPhoneImages[0].remove(at: Int(index))
            }
                playAudio(resource: "countdown", type: "wav")
        }
                  sender.setTitle("Stop", for: .normal)
        } else if sender.titleLabel?.text == "Stop"{
            for image in iPhoneCollection{
                image.image = nil
                image.backgroundColor = UIColor.black
            }
        
            timer.invalidate()
            timeSeconds = 0
            timeMinutes = 0
            iPhoneImages = images
            numMoves = 0
            selectedImage = []
            imageArray = []
            movesLabel.text = "Moves:"
            timerLabel.text = "Min: \(timeMinutes) Sec:\(timeSeconds)"
            sender.setTitle("Play", for: .normal)
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        for image in iPhoneCollection{
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
    
    func alert(){
        var counter = -1
        
        for image in iPhoneCollection{
            if image.backgroundColor == UIColor.black{
                counter += 1
            }
        }
        
        if counter == numImages {
            
            
            timer.invalidate()
            winLabel.text = "You Win!!!!"
            movesTextLabel.text = "Moves:"
            numMovesLabel.text = "\(numMoves)"
            timeLabel.text = "Time:"
            
            playButton.setTitle("Play", for: .normal)
            iPhoneImages = images
            numMoves = 0
            selectedImage = []
            imageArray = []
            movesLabel.text = "Moves:"
            timeAmountLabel.text = ""
            
            timeAmountLabel.text = "\(timeMinutes) Minute(s) \(timeSeconds) Seconds"
            timeSeconds = 0
            timeMinutes = 0
        }
    }
    
    @objc func updateTimer(){
        timeSeconds += Int(timer.timeInterval)
        
        if timeSeconds == 60{
            timeSeconds = 0
            timeMinutes += 1
        }
        timerLabel.text = "Min: \(timeMinutes) Sec:\(timeSeconds)"
    }
}

