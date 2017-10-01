//
//  RegisterViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/24/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func registerUser(_ sender: UIButton) {
        let userEmail = email.text
        let userPassword = password.text
        let userRepeatPassword = repeatPassword.text
        let personUserName = userName.text
        // Check for empty field
        guard let text = email.text, !text.isEmpty else {
            displayAlertMessage(userMessage: "邮箱不能为空")
            return
        }
        guard let pwd = password.text, !pwd.isEmpty else {
            displayAlertMessage(userMessage: "密码不能为空")
            return
        }
        guard let repeatPsw = repeatPassword.text, !repeatPsw.isEmpty else {
            displayAlertMessage(userMessage: "确认密码不能为空")
            return
        }
        guard let uName = userName.text, !uName.isEmpty else {
            displayAlertMessage(userMessage: "用户名不能为空")
            return
        }
        // Check is password match
        if (userPassword != userRepeatPassword) {
            displayAlertMessage(userMessage: "密码不匹配")
        }
        // Store data
//        UserDefaults.standard.set(userEmail, forKey: "userEmail")
//        UserDefaults.standard.set(userPassword, forKey: "userPassword")
//        UserDefaults.standard.synchronize()
        let parameters: Parameters = [
            "nickName": personUserName as Any,
            "email": userEmail as Any, //email
            "password": userPassword as Any //password
        ]
        
        //Sending http post request
        Alamofire.request("http://joinus-env.us-east-2.elasticbeanstalk.com/user/register", method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON
            {
                response in
                
                if let json = response.result.value {
                    print("JSON: \(json)") // serialized json response
                }
                if let httpStatusCode = response.response?.statusCode {
                    print("httpStatusCode: \(httpStatusCode)")
                    switch(httpStatusCode) {
                    case 200:
                        let alert = UIAlertController(title: "", message: "恭喜！注册已成功", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            action in self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    case 201:
                        let alert = UIAlertController(title: "", message: "恭喜！注册已成功", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            action in self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    default:
                        // Display error message
                        let alert = UIAlertController(title: "", message: "注册失败", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                            action in self.dismiss(animated: true, completion: nil)
                        }
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
        }
        
    }
    
    func displayAlertMessage(userMessage: String) {
        let alert = UIAlertController(title: "", message: userMessage, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
