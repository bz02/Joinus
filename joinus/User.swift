//
//  User.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/26/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import Foundation

class User {
    private var curId = 0
    private var curAge = 0
    private var curUserName = ""
    private var curEmail = ""
    private var curPassword = ""
    private var curSelfIntro = ""
    private var curGender = "Male"
    
    var email: String {
        get {
            return curEmail
        }
        set {
            curEmail = newValue
        }
    }
    
    var selfIntro: String {
        get {
            return curSelfIntro
        }
        set {
            curSelfIntro = newValue
        }
    }
    
    var gender: String {
        get {
            return curGender
        }
        set {
            curGender = newValue
        }
    }
    
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
    
    var id: Int {
        get {
            return curId
        }
        set {
            curId = newValue
        }
    }
}
