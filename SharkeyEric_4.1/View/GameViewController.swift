//
//  ViewController.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class GameViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var cardCollection: [Card]!
    
    // Member Variables
    private var viewModel = GameViewModel()
    private var selectedCard: Card?
    
    // Core Data variables.
    private var managedContext: NSManagedObjectContext!
    private var entityDescription: NSEntityDescription!
    private var leaderBoardData: NSManagedObject!
    
    // Audio
    private var player = AVAudioPlayer()
    
    // Timer
    private var timer = Timer()

    // counters and labels
    private var moves: Int = 0
    private var numImages = 0
    private var timeSeconds = 0
    private var timeMinutes = 0
    private var time = 0
    private var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting up context and entity description for CoreData.
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        entityDescription = NSEntityDescription.entity(forEntityName: "LeaderBoardData", in: managedContext)
        navigationController?.isNavigationBarHidden = true
        // Calling the function to perform the needed actions when the application is loaded.
        setUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUp(){
        animateCards()
        
        // Setting up buttons and labels.
        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
        movesLabel.text = nil
        timerLabel.text = nil
        
        // Getting images and setting the cardImage for the cards.
        if let imageArray = viewModel.imageArray{
            
            for (index, card) in cardCollection.enumerated() {
                card.cardImage = imageArray[index]
            }
        }
    }
    
    // Function to animate all the cards falling into place at the start of the game.
    func animateCards(){
        // animating card display with incrementing delay.
        var delay = 0.2
           for card in self.cardCollection{
        UIView.animate(withDuration: 0.5, delay: delay, options: .curveLinear, animations: {
        
                var frame = card.frame
                frame.origin.y += UIScreen.main.bounds.height
                card.frame = frame
            
        }, completion: nil)
            delay += 0.3
        }
    }
    
    // Function for when the PlayButton is selected.
    @IBAction func playButtonSelected(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            
            for card in cardCollection{
                card.isUserInteractionEnabled = true
                flipFront(card: card)
            }
        } else if sender.titleLabel?.text == "Stop"{
            playButton.setTitle("Play", for: .normal)
            
            for card in cardCollection{
                card.isUserInteractionEnabled = false
                
                if card.currentImage == card.cardImage {
                    flipBack(card: card)
                }
            }
            sender.setTitle("Play", for: .normal)
         reset()
        }
    }
    
    // Card flips
    func flipFront(card: Card){
        playAudio(resource: "countdown", type: "mp3")
        
            card.setImage(card.cardImage, for: .normal)
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: nil)
    }
    
    // Functio to flip card back
    func flipBack(card: Card){
        card.setImage(card.backImage, for: .normal)
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
    }
    
    // Function to keep track of the time that has passed counter the interval each time it is fired and displaying the time in the label.
    @objc func updateTimer(){
        time += Int(timer.timeInterval)
        
        timeMinutes = time / 60 % 60
        timeSeconds = time % 60
        
        timerLabel.text = String(format:"%02i:%02i", timeMinutes, timeSeconds)
    }
    
    // function to stop the the player and reset labels and counters.
    func reset(){
        // Re-setting
        for card in cardCollection{
            if card.isHidden == true {
                card.isHidden = false
            }
        }
        
        player.stop()
        timer.invalidate()
        timeSeconds = 0
        timeMinutes = 0
        time = 0
        moves = 0
        movesLabel.text = nil
        timerLabel.text = nil
    }
    
    // Function for when a card is selected.
    @IBAction func cardSelected(_ sender: UIButton) {
        
        guard let card = sender as? Card else {return}
        
        if card.currentImage == card.backImage {
            
            if let cardSelected = selectedCard {
               // There is already a card selected
                flipFront(card: card)
                card.isUserInteractionEnabled = false
                moves += 1
                movesLabel.text = "Moves: \(moves)"
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                   
                    if card.currentImage == cardSelected.cardImage {
                        self.playAudio(resource: "correct", type: "wav")
                        
                        card.isUserInteractionEnabled = true
                        cardSelected.isHidden = true
                        card.isHidden = true
                        self.selectedCard = nil
                        // TODO: Check if they are a the last two matches.
                        
                    } else {
                        self.playAudio(resource: "incorrect", type: "wav")

                        cardSelected.isUserInteractionEnabled = true
                        card.isUserInteractionEnabled = true
                        self.selectedCard = nil
                        self.flipBack(card: cardSelected)
                        self.flipBack(card: card)
                    }
                }
            } else {
                // There is no card previously selected
                playAudio(resource: "tap", type: "mp3")
                flipFront(card: card)

                selectedCard = card
                card.isUserInteractionEnabled = false
            }
        } else {
            print("Card is already flipped.")
        }
    }
    

//
//    // Alert function
//    func alert(){
//
//        // Creating a counter variable, looping through the iphoneCollection and counting to see how many imageviews are black.
//        var counter = -1
//        for image in imageViewCollection[...numImages]{
//            if image.backgroundColor == UIColor.init(displayP3Red: 1.00, green:1.00, blue:0.92, alpha:1.0) {
//                counter += 1
//            }
//        }
//
//        // If the number of black views is as many as the number of images for the device then resetting variabels and labels and displaying the win labels.
//        var alert = UIAlertController()
//        if counter == numImages {
//            timer.invalidate()
//
//            // Creating alert
//            if timeMinutes > 0{
//                alert = UIAlertController.init(title: "You Win!!", message: "You finished in \(moves) moves with a time of \(timeMinutes) minute(s) \(timeSeconds) seconds!\n\n To save your score enter your user name or initials below!", preferredStyle: .alert)
//            } else {
//                  alert = UIAlertController.init(title: "You Win!!", message: "You finished in \(moves) moves with a time of \(timeSeconds) seconds!\n To save your score enter your user name or initials below!", preferredStyle: .alert)
//            }
//
//            // Adding textfield.
//            alert.addTextField(configurationHandler: nil)
//            // Creating an alert action with completion handler to run when ok is selected.
//            let ok = UIAlertAction.init(title: "OK", style: .default, handler:{ [weak alert] (_) in
//                if let textField = alert?.textFields![0]{
//                    if let text =  textField.text{
//                            self.name = text
//                    }
//                }
//                // Calling the save function when ok is selected.
//                self.save()
//            })
//
//            // Adding alertAction and presenting alertController.
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//        }
//    }
//
//
//    // Function to save CoreData.
//    func save(){
//        if name.isEmpty{
//            name = "N/A"
//        }
//
//        // Setting values.
//        leaderBoardData = NSManagedObject(entity: entityDescription, insertInto: managedContext)
//        leaderBoardData.setValue(moves, forKey: "moves")
//        leaderBoardData.setValue(time, forKey: "time")
//        leaderBoardData.setValue(Date(), forKey: "date")
//        leaderBoardData.setValue(name, forKey: "userName")
//
//        // Saving
//        (UIApplication.shared.delegate as! AppDelegate).saveContext()
//
//        // Resetting variables
//        playButton.setTitle("Play", for: .normal)
//        moves = 0
//        selectedImage = []
//        imageArray = []
//        movesLabel.text = nil
//
//        for image in imageViewCollection[...numImages]{
//            image.backgroundColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
//            image.layer.cornerRadius = 10
//        }
//
//        timeSeconds = 0
//        timeMinutes = 0
//        time = 0
//        timerLabel.text = nil
//    }
//
//    // Passing the context and leaderBoardData to the leaderBoardViewController.
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         let sTC = segue.destination as! ScoresTableViewController
//
//        sTC.managedContext = managedContext
//        sTC.leaderBoardData = leaderBoardData
//    }
}

extension GameViewController: AVAudioPlayerDelegate {
    
    // Audio CallBacks
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        for card in cardCollection {
            flipBack(card: card)
        }
        
        // If the timer is not already valid then creating the new timer.
        if timer.isValid == false{
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    // Recieving the passed in strings getting teh path to the audio creating url passing the url to the audio player.
    func playAudio(resource: String, type: String){
        if let path = Bundle.main.path(forResource: resource, ofType: type){
            do{
                let url = URL(fileURLWithPath: path)
                player = try AVAudioPlayer(contentsOf: url)
                
                // If the resource countdown assigning the delegate to the player.
                if resource == "countdown"{
                    player.delegate = self
                }
                // Preparing the player to play
                player.prepareToPlay()
            } catch{
                print(error.localizedDescription)
            }
            // Playing the player.
            player.play()
        }
    }
}

