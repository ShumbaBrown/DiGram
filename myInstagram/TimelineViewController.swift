//
//  TimelineViewController.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/14/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var posts: [Post] = []
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view.
        var Client = ServerClient()
        
        //self.posts = Client.get
        Client.getTimeLineWithBlock(success: { (posts: [Post]) in
            self.posts = posts
            self.tableView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        /*
        Client.getTimeLineWithBlock(success: { () -> (posts: [Post]) in
            self.posts = listOfPosts
            self.tableView.reloadData()
        }) { (error: Error) in
            print(error.localizedDescription)
        }
        */
        //Client.getTimeLine(limit: 20)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! TimelineTableViewCell
        
        cell.usernameLabel.text = posts[indexPath.row].user?.username
        cell.captionLabel.text = posts[indexPath.row].caption
        cell.cellImage.file = posts[indexPath.row].image
        cell.cellImage.loadInBackground()
        cell.profileImage.file = posts[indexPath.row].user?.profilePhoto
        cell.profileImage.loadInBackground()
        cell.likeImage.image = UIImage(named: "favor-icon")
        
        if posts[indexPath.row].likes?.count == 0 || posts[indexPath.row].likes?.count == nil {
            cell.likesLabel.text = " "
        } else {
            cell.likesLabel.text = "\(posts[indexPath.row].likes?.count) likes"
        }
        cell.likeImage.isUserInteractionEnabled = true
        let cellLike = UITapGestureRecognizer(target: self, action: #selector(self.likePost(recognizer:)))
        cell.likeImage.addGestureRecognizer(cellLike)
        return cell
    }
    
    func likePost(recognizer: UIGestureRecognizer) {
        print("like post!")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("post count: \(self.posts.count)")
        return self.posts.count
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
