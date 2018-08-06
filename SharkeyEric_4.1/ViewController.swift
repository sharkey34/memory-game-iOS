//
//  ViewController.swift
//  SharkeyEric_4.1
//
//  Created by Eric Sharkey on 8/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var cellImages: [UIImage] = []
    var iPhoneImages: [[UIImage]] = [[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")],[#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask"),#imageLiteral(resourceName: "misc space rocket"),#imageLiteral(resourceName: "monetary gold bars"),#imageLiteral(resourceName: "dressup lips"),#imageLiteral(resourceName: "emoticons crush"),#imageLiteral(resourceName: "emoticons laughing out loud"),#imageLiteral(resourceName: "music speaker"),#imageLiteral(resourceName: "magic ripped eye"),#imageLiteral(resourceName: "monster zombie2"),#imageLiteral(resourceName: "monster brain"),#imageLiteral(resourceName: "magic triangle flask")]]
    var selectedImage: [UIImage] = []

    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? ImageCollectionViewCell else {return collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)}
        let index = arc4random_uniform(UInt32(iPhoneImages[0].count))
        cell.cellImage.image = iPhoneImages[0][Int(index)]
        
        iPhoneImages[0].remove(at: Int(index))
        
    return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch selectedImage.count {
        case 0:
            selectedImage.append(iPhoneImages[1][indexPath.row])
        case 1:
            selectedImage.append(iPhoneImages[1][indexPath.row])
            
            if selectedImage[0] == selectedImage[1] {
                print("Congrats")
            } else {
                print("Try again.")
            }
            selectedImage.removeAll()
        default:
            print("Index out of range.")
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

}

