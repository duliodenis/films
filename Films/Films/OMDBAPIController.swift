//
//  OMDBAPIController.swift
//  Films
//
//  Created by Dulio Denis on 8/14/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

import UIKit

protocol OMDBAPIControllerDelegate {
    func didFinishOMDBSearch(result: Dictionary<String, String>)
}

class OMDBAPIController {
    var delegate: OMDBAPIControllerDelegate?
    
    init(delegate: OMDBAPIControllerDelegate?) {
        self.delegate = delegate
    }
}
