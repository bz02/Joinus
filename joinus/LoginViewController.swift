//
//  LoginViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/24/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func userLogin(_ sender: UIButton) {
        let email = userEmail.text
        let passWord = userPassword.text
        
        let parameters: Parameters = [
            "email": email as Any, //email
            "password": passWord as Any //password
        ]
        
        //Sending http post request
        Alamofire.request("http://joinus-env.us-east-2.elasticbeanstalk.com/user/login", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON
            {
                response in
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                //getting the json value from the server
                if let result = response.result.value {
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    if let httpStatusCode = response.response?.statusCode {
                        print("httpStatusCode: \(httpStatusCode)")
                        switch(httpStatusCode) {
                        case 200:
                            UserDefaults.standard.set(true, forKey: "isUserLoggedin")
                            UserDefaults.standard.set(jsonData["token"] as! String, forKey: "token")
                            UserDefaults.standard.set(email, forKey: "Username")
                            UserDefaults.standard.synchronize()
                            self.dismiss(animated: true, completion: nil)
                        case 201:
                            UserDefaults.standard.set(true, forKey: "isUserLoggedin")
                            UserDefaults.standard.set(jsonData["Token"], forKey: "token")
                            UserDefaults.standard.set(email, forKey: "Username")
                            UserDefaults.standard.synchronize()
                            self.dismiss(animated: true, completion: nil)
                        default:
                            // Display error message
                            let alert = UIAlertController(title: "", message: "登录失败", preferredStyle: UIAlertControllerStyle.alert)
                            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                                action in self.dismiss(animated: true, completion: nil)
                            }
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
