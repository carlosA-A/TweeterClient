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
    
    
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var tweets: [Tweet]?
    
        var tweet: Tweet! {
        didSet {
            
            
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            
            var dateFormatter = NSDateFormatter()
            
                        
            favoriteCountLabel.text = String(tweet.favouriteCount!)
            
            
            tweetTextLabel.text = tweet.text!
            tweetTextLabel.sizeToFit()
        
    
            profileImageView.setImageWithURL((tweet.user?.profileImageUrl)!)
            profileImageView.layer.cornerRadius = 6
            profileImageView.clipsToBounds = true
            
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
    @IBAction func retweetButton(sender: AnyObject) {
        
        onRetweet()
    }
    func onRetweet(){
        //retweetCountLabel.text = "\(tweet.retweetCount!+1)"
        var id = tweet?.retweetId
        var idDictionary = [id!: id!] as NSDictionary
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
        }
        id = self.tweet?.retweetId
        
        if !tweet.retweetBool!{
            retweetCountLabel.text = "\(tweet.retweetCount!+1)"
            TwitterClient.sharedInstance.retweetWithParams(idDictionary) { (id, error) -> () in
                
            }
            
        }else{}
        
        
        
        // TwitterClient.sharedInstance.retweetWithParams(nil){
        // (id, error)-> () in

        
    
    }

}
