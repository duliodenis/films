//
//  ViewController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OMDBAPIControllerDelegate {
    
    // Outlets to the View
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var releaseLabel      : UILabel!
    @IBOutlet var ratingLabel       : UILabel!
    @IBOutlet var plotLabel         : UILabel!
    @IBOutlet var posterImageView   : UIImageView!
    
    // Lazy Stored Property
    lazy var apiController: OMDBAPIController = OMDBAPIController(delegate: self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // become the delegate of the OMDB API Controller
        apiController.delegate = self
    }
    
    
    @IBAction func buttonTapped(sender: UIButton) {
        apiController.searchOMDB("Lost Highway")
    }

    
    // Set the label in our View
    func didFinishOMDBSearch(result: Dictionary<String, String>) {
        titleLabel.text = result["Title"]
        releaseLabel.text = result["Released"]
        ratingLabel.text = "Rated " + result["Rated"]!
        plotLabel.text = result["Plot"]
        
        if let foundPoster = result["Poster"] {
            imageFromPath(foundPoster)
        }
    }
    
    
    func imageFromPath(path: String) {
        let posterURL = NSURL(string: path)
        let posterImageData = NSData(contentsOfURL: posterURL!)
        posterImageView.clipsToBounds = true
        posterImageView.image = UIImage(data: posterImageData!)
    }
}
