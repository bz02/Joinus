//
//  Activity.swift
//  Joinus
//
//  Created by Xiaobo Zhang on 9/17/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import Foundation

class Activity {
    private var curTitle = ""
    private var curLocation = ""
    
    private var curDescription = ""
    
    var title: String {
        get {
            return curTitle
        }
        set {
            curTitle = newValue
        }
    }
    
    var location: String {
        get {
            return curLocation
        }
        set {
            curLocation = newValue
        }
    }
    
    var descrition: String {
        get {
            return curDescription
        }
        set {
            curDescription = newValue
        }
    }
    
    func submitActivity() {
        
    }
}
