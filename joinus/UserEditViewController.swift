//
//  UserEditViewController.swift
//  joinus
//
//  Created by Xiaobo Zhang on 9/26/17.
//  Copyright © 2017 Joinus Tech. All rights reserved.
//

import UIKit

class UserEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var user = User()
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var genderLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var ageLabel: UITextField!
    @IBOutlet weak var workLabel: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBAction func changeImage(_ sender: UIButton) {
        let imagePrickerController = UIImagePickerController()
        imagePrickerController.delegate = self
        let actionSheet = UIAlertController(title: "请选择照片来源", message: "照片来源", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "拍照", style: .default, handler: { (action: UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePrickerController.sourceType = .camera
                self.present(imagePrickerController, animated: true, completion: nil)
            } else {
                print("照相机没法使用")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "从手机相册中选择", style: .default, handler: { (action: UIAlertAction) in
            imagePrickerController.sourceType = .photoLibrary
            self.present(imagePrickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("username: \(user.userName)")
        profileImage.image = UIImage(named: "cat.png")
        nameLabel.text = user.userName
        genderLabel.text = user.gender
        ageLabel.text = String(user.age)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
