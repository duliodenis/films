//
//  OMDBAPIController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit


// Specify the OMDB API Protocol
protocol OMDBAPIControllerDelegate {
    func didFinishOMDBSearch(result: Dictionary<String, String>)
}


class OMDBAPIController {
    // Optional delegate property adheres to OMDB API protocol
    var delegate: OMDBAPIControllerDelegate?
    
    // initializer accepts optional delegate and sets it
    init(delegate: OMDBAPIControllerDelegate?) {
        self.delegate = delegate
    }
    
    
    func searchOMDB(forContent:String) {
        var spacelessString = forContent.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        print("Spaceless string: " + spacelessString! + "\n")
        
        let urlPath = NSURL(string: "http://www.omdbapi.com/?t=\(spacelessString!)&tomatoes=true")!
        print(urlPath)
        print("\n")
        
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
            
            // Optional Binding to check to see that we do have the optional delegate
            if let apiDelegate = self.delegate {
                
                // send the json results to the delegate on the main queue
                dispatch_async(dispatch_get_main_queue()) {
                    apiDelegate.didFinishOMDBSearch(jsonResult)
                }
            }
    
        }
        task.resume()
    }
}
