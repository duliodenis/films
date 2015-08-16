//
//  ViewController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OMDBAPIControllerDelegate, UISearchBarDelegate {
    
    // Outlets to the View
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var releaseLabel      : UILabel!
    @IBOutlet var ratingLabel       : UILabel!
    @IBOutlet var plotLabel         : UILabel!
    @IBOutlet var posterImageView   : UIImageView!
    @IBOutlet var omdbSearchBar     : UISearchBar!
    
    // Lazy Stored Property
    lazy var apiController: OMDBAPIController = OMDBAPIController(delegate: self)
    
    
    // MARK: - View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tap gesture and add it to view
        let tapGesture = UITapGestureRecognizer(target: self, action: "tappedInView:")
        view.addGestureRecognizer(tapGesture)
        
        // become the delegate of the OMDB API Controller
        apiController.delegate = self
    }

    
    // MARK: - OMDB API Controller Delegate Method
    
    func didFinishOMDBSearch(result: Dictionary<String, String>) {
        // Set the label in our View
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
    
    
    // MARK: - Search Bar Delegate Method
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {        
        apiController.searchOMDB(searchBar.text)
        
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    
    // MARK: - Tap Gesture Recognizer Method
    
    func tappedInView(recognizer: UITapGestureRecognizer) {
        omdbSearchBar.resignFirstResponder()
    }
    
}
