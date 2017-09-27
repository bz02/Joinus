//
//  User.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/26/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import Foundation

class User {
    private var curUserName = ""
    private var curPassword = ""
    private var curAge = 1
    private var curSex = "Male"
    
    
    var userName: String {
        get {
            return curUserName
        }
        set {
            curUserName = newValue
        }
    }
    
    var password: String {
        get {
            return curPassword
        }
        set {
            curPassword = newValue
        }
    }
    
    var age: Int {
        get {
            return curAge
        }
        set {
            curAge = newValue
        }
    }
}
