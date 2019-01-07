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
    @IBOutlet var iPhoneCards: [Card]!
    @IBOutlet var iPadCards: [Card]!
    
    // Member Variables
    private var viewModel = GameViewModel()
    private var selectedCards: [Card] = []
    private var gameCards: [Card] = []
    
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
        playButton.isEnabled = false
        
        // Getting images and setting the cardImage for the cards.
        if let imageArray = viewModel.imageArray{
            
            switch imageArray.count {
            case 20:
            gameCards = iPhoneCards
            case 30:
            gameCards = iPadCards
            default:
                print("Incorrect number of cards")
            }
            animateCards()
            
            // Setting up buttons and labels.
            playButton.titleLabel?.adjustsFontSizeToFitWidth = true
            movesLabel.text = nil
            timerLabel.text = nil
            
            for (index, card) in gameCards.enumerated() {
                card.cardImage = imageArray[index]
            }
        }
    }
    
    // Function to animate all the cards falling into place at the start of the game.
    func animateCards(){
        // animating card display with incrementing delay.
        var delay = 0.1
        var counter = 0
           for card in self.gameCards{
            
            card.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1, delay: delay, options: .curveLinear, animations: {
        
                var frame = card.frame
            
            switch counter {
            case 0:
                frame.origin.y -= UIScreen.main.bounds.height
                counter += 1
            case 1:
                frame.origin.x += UIScreen.main.bounds.width
                counter += 1
            case 2:
                frame.origin.y += UIScreen.main.bounds.height
                counter += 1
            case 3:
                frame.origin.x -= UIScreen.main.bounds.width
                counter = 0
            default:
                print("Whoops")
            }
            
                card.frame = frame
    
        }, completion: nil)
            delay += 0.1
        }
        playButton.isEnabled = true

    }
    
    // Function for when the PlayButton is selected.
    @IBAction func playButtonSelected(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Play" {
            playButton.setTitle("Stop", for: .normal)
            
            for card in gameCards{
                card.isUserInteractionEnabled = true
                playAudio(resource: "countdown", type: "mp3")
                flipFront(card: card)
            }
        } else if sender.titleLabel?.text == "Stop"{
         reset()
        }
    }
    
    // Card flips
    func flipFront(card: Card){
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
        for card in gameCards{
            if card.isHidden == true {
                card.isHidden = false
            }
        }
        
        for card in gameCards{
            card.isUserInteractionEnabled = false
            
            if card.currentImage == card.cardImage {
                flipBack(card: card)
            }
        }
        
        // Getting images and setting the cardImage for the cards.
        if let imageArray = viewModel.imageArray{
            
            switch imageArray.count {
            case 20:
                gameCards = iPhoneCards
            case 30:
                gameCards = iPadCards
            default:
                print("Incorrect number of cards")
            }
            
            for (index, card) in gameCards.enumerated() {
                card.cardImage = imageArray[index]
            }
        }
        
        self.playButton.setTitle("Play", for: .normal)
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
                        
            switch selectedCards.count {
            case 0:
                // There is no card previously selected
                playAudio(resource: "tap", type: "mp3")
                flipFront(card: card)
                
                selectedCards.append(card)
                card.isUserInteractionEnabled = false
            case 1:
                playAudio(resource: "tap", type: "mp3")
                
                selectedCards.append(card)
                
                // There is already a card selected
                flipFront(card: card)
                card.isUserInteractionEnabled = false
                moves += 1
                movesLabel.text = "Moves: \(moves)"
                
                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                    
                    if card.currentImage == self.selectedCards[0].cardImage {
                        self.playAudio(resource: "correct", type: "wav")
                        
                        card.isUserInteractionEnabled = true
                        self.selectedCards[0].isHidden = true
                        card.isHidden = true
                        self.selectedCards = []
                        // Check if they are the last two matches.
                        for cards in self.gameCards {
                            if cards.isHidden == false{
                                return
                            }
                        }
                        self.alert()
                    } else {
                        self.playAudio(resource: "incorrect", type: "wav")
                        
                        self.selectedCards[0].isUserInteractionEnabled = true
                        card.isUserInteractionEnabled = true
                        self.flipBack(card: self.selectedCards[0])
                        self.flipBack(card: card)
                        self.selectedCards = []
                    }
                }
            default:
                print("Two cards already flipped.")
            }
        } else {
            print("Card is already flipped.")
        }
    }
    


    // Alert function
    func alert(){

        // If the number of black views is as many as the number of images for the device then resetting variabels and labels and displaying the win labels.
        var alert = UIAlertController()
        
            timer.invalidate()
            // Creating alert
            if timeMinutes > 0{
                alert = UIAlertController.init(title: "You Win!!", message: "You finished in \(moves) moves with a time of \(timeMinutes) minute(s) \(timeSeconds) seconds!\n\n To save your score enter your user name or initials below!", preferredStyle: .alert)
            } else {
                  alert = UIAlertController.init(title: "You Win!!", message: "You finished in \(moves) moves with a time of \(timeSeconds) seconds!\n To save your score enter your user name or initials below!", preferredStyle: .alert)
            }

            // Adding textfield.
            alert.addTextField(configurationHandler: nil)
            // Creating an alert action with completion handler to run when ok is selected.
            let ok = UIAlertAction.init(title: "OK", style: .default, handler:{ [weak alert] (_) in
                if let textField = alert?.textFields![0]{
                    if let text =  textField.text{
                            self.name = text
                    }
                }
                // Calling the save function when ok is selected.
                self.save()
                self.reset()
            })

            // Adding alertAction and presenting alertController.
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
    }


    // Function to save CoreData.
    func save(){
        
        if name.isEmpty{
            name = "N/A"
        }

        // Setting values.
        leaderBoardData = NSManagedObject(entity: entityDescription, insertInto: managedContext)
        leaderBoardData.setValue(moves, forKey: "moves")
        leaderBoardData.setValue(time, forKey: "time")
        leaderBoardData.setValue(Date(), forKey: "date")
        leaderBoardData.setValue(name, forKey: "userName")

        // Saving
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }

    // Passing the context and leaderBoardData to the leaderBoardViewController.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let sTC = segue.destination as! ScoresTableViewController

        sTC.managedContext = managedContext
        sTC.leaderBoardData = leaderBoardData
    }
}

extension GameViewController: AVAudioPlayerDelegate {
    
    // Audio CallBacks
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        for card in gameCards {
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

