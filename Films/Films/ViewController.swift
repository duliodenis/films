//
//  ViewController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var titleLabel        : UILabel!
    @IBOutlet var releaseLabel      : UILabel!
    @IBOutlet var ratingLabel       : UILabel!
    @IBOutlet var plotLabel         : UILabel!
    @IBOutlet var posterLabelView   : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        titleLabel.text = "Lost Highway"
        releaseLabel.text = "21 Feb 1997"
        ratingLabel.text = "Rated R"
        plotLabel.text = "After a bizarre encounter at a party, a jazz saxophonist is framed for the murder of his wife and sent to prison, where he inexplicably morphs into a young mechanic and begins leading a new life."
        posterLabelView.image = UIImage(named: "samplePoster")
        
        searchOMDB("Lost Highway")
    }
    
    func searchOMDB(forContent:String) {
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        print(spacelessString)
        
        var urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(spacelessString)")
        print(urlPath)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(urlPath!) {
            data, response, error -> Void in
            
            if ((error) != nil) {
                print(error.localizedDescription)
            }
            
            var jsonError : NSError?
            var jsonResult : NSJSONSerialization
        }
        
    }

}
