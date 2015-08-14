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
        posterLabelView.image = UIImage(named: "samplePoster")
        
        searchOMDB("Lost Highway")
    }
    
    func searchOMDB(forContent:String) {
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        print(spacelessString)
        
        let urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(spacelessString!)")!
        print(urlPath)
        
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithURL(urlPath) {
            data, response, error -> Void in
            
            if ((error) != nil) {
                print(error.localizedDescription)
            }
            
            var jsonError : NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &jsonError) as! Dictionary<String, String>
            
            if ((jsonError) != nil) {
                print(jsonError!.localizedDescription)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                // Set label values
                self.titleLabel.text = jsonResult["Title"]
                self.releaseLabel.text = jsonResult["Released"]
                self.ratingLabel.text = "Rated " + jsonResult["Rated"]!
                self.plotLabel.text = jsonResult["Plot"]
            }
        }
        task.resume()
    }

}
