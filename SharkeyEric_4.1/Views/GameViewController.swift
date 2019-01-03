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

class GameViewController: UIViewController, AVAudioPlayerDelegate {
    
    // Creating outlets to access the needed UI elements.
    
    // New and Improved
    @IBOutlet var viewBottomConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet var cardCollection: [Card]!
    
    // New Member Variables
    private var viewModel = GameViewModel()
    private var cards: [Card]?
    
//    @IBOutlet var imageViewCollection: [UIImageView]!
    // Creating variables for the audioPlayer, to hold the images for each device, number of moves, and other information needed in the application.
    private var player = AVAudioPlayer()
    private var selectedImage: [Int] = []
    private var imageArray: [UIImage] = []
    private var moves: Int = 0
    private var numImages = 0
    private var timer = Timer()
    private var timeSeconds = 0
    private var timeMinutes = 0
    private var time = 0
    private var name = ""
    private var leaderBoardData: NSManagedObject!
    
    // Core Data variables.
    private var managedContext: NSManagedObjectContext!
    private var entityDescription: NSEntityDescription!
    
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
        
        
        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
        // Setting all the labels to nil.
        movesLabel.text = nil
        timerLabel.text = nil
        
        
    }
    
//    func setupViewDidLoad(){
//        // Checking the current device and setting the numImages variable accordingly.
//        switch UIDevice.current.userInterfaceIdiom {
//        case .phone:
//            numImages = 19
//        case .pad:
//            numImages = 29
//        default:
//            print("Device Unsepecified.")
//        }
//
//        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
//        // Setting all the labels to nil.
//        movesLabel.text = nil
//        timerLabel.text = nil
//
//        for view in viewCollection[...numImages]{
//            view.layer.cornerRadius = 10
//        }
//
//        // Looping through the imageView collection and setting the background color and the cornerRadius, and adding a tap gesture to the image views
//        for image in imageViewCollection[...numImages]{
//            let tap = UITapGestureRecognizer(target: self, action: #selector(GameViewController.imageTapped(sender:)))
//            image.addGestureRecognizer(tap)
//            image.backgroundColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
//            image.layer.cornerRadius = 10
//        }
//    }
//
//
//    // Function to run when image is tapped.
//    @objc func imageTapped(sender: UITapGestureRecognizer){
//        // Checking that the sender is an imageView.
//        guard let imageView = sender.view as? UIImageView else {return}
//
//        // Making sure the image selected is flipped over, Then playing the tap audio
//        if imageView.image == nil{
//            playAudio(resource: "tap", type: "mp3")
//
//            // if the selected image count is 0 then adding the imageViews tag that was selected to the selected imageArray
//            // Disabling user interaction and setting the imageViews image to the selected image.
//            switch selectedImage.count {
//            case 0:
//                selectedImage.append(imageView.tag)
//                imageView.isUserInteractionEnabled = false
//                imageViewCollection[imageView.tag].image = imageArray[imageView.tag]
//
//            // If there already is an image selected then upping the number of moves, setting userInteraction to false and displaying the image associated with that imageView.
//            case 1:
//                moves += 1
//                movesLabel.text = "Moves: \(moves)"
//                selectedImage.append(imageView.tag)
//                imageView.isUserInteractionEnabled = false
//                imageViewCollection[imageView.tag].image = imageArray[imageView.tag]
//                // Stalling for .5 seconds to display the second card to the user. when the time is up comparing the two selected images.
//                // if they are correct playing the correct sound and turning the image views over setting the images to nil.
//                DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
//                    if self.imageArray[self.selectedImage[0]] == self.imageArray[self.selectedImage[1]] {
//                        self.playAudio(resource: "correct", type: "wav")
//                        for index in self.selectedImage{
//                            self.imageViewCollection[index].backgroundColor = UIColor.init(displayP3Red: 1.00, green:1.00, blue:0.92, alpha:1.0)
//                            self.imageViewCollection[index].image = nil
//                        }
//                        // Checking to see if they are the last two imageViews and display the win message.
//                        self.alert()
//                        // If they are not correct playing the incorrect sound and setting the image back to nil.
//                    } else {
//                        self.playAudio(resource: "incorrect", type: "wav")
//                        for index in self.selectedImage{
//                            self.imageViewCollection[index].isUserInteractionEnabled = true
//                            self.imageViewCollection[index].image = nil
//                        }
//                    }
//                    self.selectedImage.removeAll()
//                }
//            default:
//                print("Invalid Index")
//            }
//        } else {
//            print("cards flipped")
//        }
//    }
//
//    @IBAction func playButtonSelected(_ sender: UIButton) {
//        // Checking to see if the play button was selected then which device the user is using.
//        if sender.titleLabel?.text == "Play"{
//
//            switch UIDevice.current.userInterfaceIdiom {
//            // If the button was play and the user is using a phone and allowing user interaction
//            case .phone:
//                for image in imageViewCollection[...numImages]{
//                    image.isUserInteractionEnabled = true
//                    image.backgroundColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
//                    // Getting a random index setting the imageView image to a random image based on the index.
//                    // Adding to the imageArray and removing the image from the iPhoneImages.
//                    let index:Int = Int(arc4random_uniform(UInt32(iPhoneImages.count)))
//                    image.image = iPhoneImages[index]
//                    imageArray.append(iPhoneImages[index])
//                    iPhoneImages.remove(at: index)
//                }
//                // Setting the iPhoneImages array to the imageArray.
//                iPhoneImages = imageArray
//            // If the user is using an iPad then looping through the collection adding the random image and removing from iPadImages array.
//            case .pad:
//                for image in imageViewCollection[...numImages]{
//                    image.backgroundColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
//                    image.isUserInteractionEnabled = true
//                    let index: Int = Int(arc4random_uniform(UInt32(iPadImages.count)))
//                    image.image = iPadImages[index]
//                    imageArray.append(image.image!)
//                    iPadImages.remove(at: index)
//                }
//                // Setting the iPadImages to the imageArray.
//                iPadImages = imageArray
//            default:
//                print("Device unspecified.")
//            }
//            // Playing countdown audio and setting the buttons title to stop.
//            playAudio(resource: "countdown", type: "mp3")
//            sender.setTitle("Stop", for: .normal)
//
//            // If the title equals stop then looping through the image collection and setting the images to nil and the backgroung color to blue.
//        } else if sender.titleLabel?.text == "Stop"{
//            for image in imageViewCollection{
//                image.image = nil
//                image.isUserInteractionEnabled = false
//                image.backgroundColor = UIColor.init(displayP3Red: 0.63, green:0.86, blue:1.00, alpha:1.0)
//            }
//
//            // Stopping the audio, invalidating the timer and resetting variables and labels, then setting the button title to Play.
//            player.stop()
//            timer.invalidate()
//            timeSeconds = 0
//            timeMinutes = 0
//            time = 0
//            moves = 0
//            selectedImage = []
//            imageArray = []
//            movesLabel.text = ""
//            timerLabel.text = ""
//            sender.setTitle("Play", for: .normal)
//        }
//    }
//
//    // When the audio is finished playing setting the imageviews images to nil.
//    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//        for image in imageViewCollection{
//            image.image = nil
//        }
//
//        // If the timer is not already valid then creating the new timer.
//        if timer.isValid == false{
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
//        }
//    }
//
//    // Recieving the passed in strings getting teh path to the audio creating url passing the url to the audio player.
//    func playAudio(resource: String, type: String){
//        if let path = Bundle.main.path(forResource: resource, ofType: type){
//            do{
//                let url = URL(fileURLWithPath: path)
//                player = try AVAudioPlayer(contentsOf: url)
//
//                // If the resource countdown assigning the delegate to the player.
//                if resource == "countdown"{
//                    player.delegate = self
//                }
//                // Preparing the player to play
//                player.prepareToPlay()
//            } catch{
//                print(error.localizedDescription)
//            }
//            // Playing the player.
//            player.play()
//        }
//    }
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
//    // Function to keep track of the time that has passed counter the interval each time it is fired and displaying the time in the label.
//    @objc func updateTimer(){
//        time += Int(timer.timeInterval)
//
//         timeMinutes = time / 60 % 60
//         timeSeconds = time % 60
//
//        timerLabel.text = String(format:"%02i:%02i", timeMinutes, timeSeconds)
//    }
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

