//
//  TimelineTableViewCell.swift
//  myInstagram
//
//  Created by Shumba Brown on 3/14/17.
//  Copyright © 2017 Shumba Brown. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: PFImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet var cellImage: PFImageView!
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var likesLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
