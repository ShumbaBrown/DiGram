//
//  SignUpViewController.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/13/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    @IBOutlet var signUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.signUpView.addGestureRecognizer(tapGesture)
    }
    
    func tap(_ gesture: UITapGestureRecognizer) {
        self.signUpView.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        // Check to ensure all fields are filled
        // Check to ensure passwords match
        self.signUpView.endEditing(true)
        
        var newUserForm = User()
        newUserForm.username = usernameTextField.text
        newUserForm.password = passwordTextField.text
        newUserForm.profilePhoto = getPFFileFromImage(image: UIImage(named: "profile-photo"))
        
        var Client = ServerClient()
        
        Client.AddUser(user: newUserForm, successful: { 
            self.performSegue(withIdentifier: "signUpSuccess", sender: self)
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
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
