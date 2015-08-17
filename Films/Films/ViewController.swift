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
    @IBOutlet var subtitleLabel     : UILabel!
    @IBOutlet var releaseLabel      : UILabel!
    @IBOutlet var ratingLabel       : UILabel!
    @IBOutlet var plotLabel         : UILabel!
    @IBOutlet var posterImageView   : UIImageView!
    @IBOutlet var omdbSearchBar     : UISearchBar!
    
    // Lazy Stored Property
    lazy var apiController: OMDBAPIController = OMDBAPIController(delegate: self)
    
    
    // MARK: - View Lifecycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tap gesture and add it to view
        let tapGesture = UITapGestureRecognizer(target: self, action: "tappedInView:")
        view.addGestureRecognizer(tapGesture)
        
        // become the delegate of the OMDB API Controller
        apiController.delegate = self
        
        // format our view labels since this is the first launch
        formatLabels(firstLaunch: true)
    }

    
    // MARK: - OMDB API Controller Delegate Method
    
    func didFinishOMDBSearch(result: Dictionary<String, String>) {
        // Set the labels in our View
        formatLabels(firstLaunch: false)
        
        if let foundTitle = result["Title"] {
            parseSubtitleFromTitle(foundTitle)
        }
        
        releaseLabel.text = result["Released"]
        ratingLabel.text = "Rated " + result["Rated"]!
        plotLabel.text = result["Plot"]
        
        if let foundPoster = result["Poster"] {
            imageFromPath(foundPoster)
        }
    }
    
    
    // MARK: - Label and Text Helper Methods
    
    // force using a named parameters when calling the function by # prefixing the local name
    func formatLabels(#firstLaunch: Bool) {
        // create a convenience labels array to iterate through all view labels
        var labelsArray = [titleLabel, subtitleLabel, releaseLabel, ratingLabel, plotLabel]
        
        if (firstLaunch) {
            // iterate over the labels array and set the label to an empty string
            for label in labelsArray {
                label.text = ""
            }
        }
        
        // iterate through the labels to set their alignment and font
        for label in labelsArray {
            label.textAlignment = .Center
            
            switch label {
            
            case titleLabel:
                label.font = UIFont(name: "Avenir Next", size: 24)
                
            case subtitleLabel:
                label.font = UIFont(name: "Avenir Next", size: 14)
                
            case releaseLabel, ratingLabel:
                label.font = UIFont(name: "Avenir Next", size: 12)
                
            case plotLabel:
                label.font = UIFont(name: "Avenir Next", size: 18)
                
            default:
                label.font = UIFont(name: "Avenir Next", size: 14)
            }
        }
    }
    
    
    func parseSubtitleFromTitle(title: String) {
        // use the extension to find a colon in the title
        var index = title.findIndexOf(":")
        
        // If we have a colon then split the title
        if let foundIndex = index {
            var newTitle = title[0..<foundIndex]
            var subtitle = title[foundIndex + 2..<count(title)]
            
            // and set the labels accordingly
            titleLabel.text = newTitle
            subtitleLabel.text = subtitle
        } else {
            // otherwise we just have a title and no subtitle
            titleLabel.text = title
            subtitleLabel.text = ""
        }
    }
    
    
    // MARK: - Image Helper Functions
    
    func imageFromPath(path: String) {
        let posterURL = NSURL(string: path)
        let posterImageData = NSData(contentsOfURL: posterURL!)
        posterImageView.clipsToBounds = true
        posterImageView.image = UIImage(data: posterImageData!)
        
        if let imageBlur = posterImageView.image {
            blurBackgroundImage(imageBlur)
        }
    }
    
    
    func blurBackgroundImage(image: UIImage) {
        // Make a frame the size of the current view
        var frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        // Make an image view using that frame
        var imageView = UIImageView(frame: frame)
        
        // Push the received image into the new image view and scale it
        imageView.image = image
        imageView.contentMode = .ScaleAspectFill
        
        // Create a blur effect view and blur effect
        var blurEffect = UIBlurEffect(style: .Light)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        
        // set up a layer with 30% alpha to dull the blur colors
        var transparentWhiteView = UIView(frame: frame)
        transparentWhiteView.backgroundColor = UIColor(white: 1.0, alpha: 0.30)
        
        // Add views to our view with an Array
        var viewsArray = [imageView, blurEffectView, transparentWhiteView]
        
        // use a half closed range
        for index in 0..<viewsArray.count {
            // remove any old background views with tags
            if let oldView = view.viewWithTag(index + 1) {
                oldView.removeFromSuperview()
            }
            
            // insert the view into
            var viewToInsert = viewsArray[index]
            view.insertSubview(viewToInsert, atIndex: index + 1)
            // add the tag in order to remove for the next time
            viewToInsert.tag = index + 1
        }
    }
    
    
    // MARK: - Search Bar Delegate Method
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {        
        apiController.searchOMDB(searchBar.text)
        
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    
    // MARK: - Tap Gesture Recognizer Method
    
    // clear the search and dismiss the keyboard if the user taps in the view
    func tappedInView(recognizer: UITapGestureRecognizer) {
        omdbSearchBar.text = ""
        omdbSearchBar.resignFirstResponder()
    }
    
}
