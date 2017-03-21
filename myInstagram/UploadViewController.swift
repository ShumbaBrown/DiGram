//
//  UploadViewController.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/14/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse

class UploadViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    var image: UIImage? = nil
    
    @IBOutlet var uploadView: UIView!
    var slide: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize = UIScreen.main.bounds
        self.imageViewWidth.constant = screenSize.width
        self.imageViewHeight.constant = screenSize.width
        
        
        if let image = image {
            self.imageView.image = image
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        self.uploadView.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);

        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if !slide {
            self.view.frame.origin.y -= 150
            self.slide = true
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if slide {
            self.view.frame.origin.y += 180
            self.slide = false
        }
        
    }
    
    func tap(_ gesture: UITapGestureRecognizer) {
        self.uploadView.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPost(_ sender: Any) {
        
        var Client = ServerClient()
        let newPost = Post()
        
        newPost.image = getPFFileFromImage(image: self.image)
        if captionTextField.text != nil {
            newPost.caption = captionTextField.text!
        }
        else {
            newPost.caption = ""
        }
        var user = User()
        
        user.setupFrom(userDictionary: PFUser.current()!)
        newPost.user = user
        Client.createPost(post: newPost, successful: { 
            self.performSegue(withIdentifier: "FromPostToTimeline", sender: self)
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
    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "FromPostToTimeline", sender: self)
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
