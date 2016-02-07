//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/7/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
        var tweet: Tweet! {
        didSet {
            let retweet = String(tweet.retweetCount!)
            retweetCountLabel.text = retweet
            
            var dateFormatter = NSDateFormatter()
            
                        
            favoriteCountLabel.text = String(tweet.favouriteCount!)
            favoriteImageView.image = UIImage(named: "favorite")
            
            tweetTextLabel.text = tweet.text!
            tweetTextLabel.sizeToFit()
        
            retweetImageView.image = UIImage(named: "retweet")
    
            profileImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
            profileImageView.layer.cornerRadius = 6
            
            nameLabel.text = tweet.user!.name!
            userNameLabel.text = "@"+(tweet.user?.screenname)!
            dateFormatter.dateFormat = "MMM d HH:mm y"
            var dateString = dateFormatter.stringFromDate(tweet.createdAt!)
            
            timeStampLabel.text = dateString        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
