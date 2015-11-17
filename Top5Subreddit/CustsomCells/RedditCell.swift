//
//  RedditCell.swift
//  Top5Subreddit
//
//  Created by Ray Venenoso on 11/17/15.
//  Copyright © 2015 RAYVEN Creatives. All rights reserved.
//

import UIKit

class RedditCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var redditImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        redditImage.clipsToBounds = true
        redditImage.layer.cornerRadius = 23
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
