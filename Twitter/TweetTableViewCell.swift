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
    
    @IBOutlet weak var favoriteIcon: UIButton!
    
    @IBOutlet weak var retweetIcon: UIButton!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var tweets: [Tweet]?
    var retweetBool : Bool?
    var favoriteBool: Bool?

    
        var tweet: Tweet! {
        didSet {
            
            //profileImageView.userInteractionEnabled = true
            
            retweetCountLabel.text = "\(tweet.retweetCount!)"
            
            var dateFormatter = NSDateFormatter()
            
                        
            favoriteCountLabel.text = String(tweet.favouriteCount!)
            
            retweetBool = tweet.retweetBool
            
            retweetIcon = nil
            
           
            
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
    @IBAction func favoriteButton(sender: AnyObject) {
        onFavorite()
    }
    @IBAction func retweetButton(sender: AnyObject) {
        
        onRetweet()
    }
    //Function for when favorite button is pressed
    func onFavorite(){
        var id = tweet.id
        
        let idDictionary = ["id": id!]
        
        TwitterClient.sharedInstance.getTweetWithParams(idDictionary) { (tweet, error) -> () in
            self.tweet! = tweet!
            
        }
        
        id = self.tweet!.id
        if !tweet.favoriteBool! {
            //var retweetCount = Int(self.retweetCountLabel.text!)
            
            
            tweet.favouriteCount = tweet.favouriteCount! + 1
            
            self.favoriteCountLabel.text = "\(tweet.favouriteCount!)"
            
            self.favoriteBool = !tweet.favoriteBool!
            
            
            TwitterClient.sharedInstance.favoriteWithParams(idDictionary, completion: { (id, error) -> () in
                
            })
            favoriteIcon.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
            
        } else {
            
            
            // self.retweetCountLabel.text = "\(retweetCount!)"
            
            
            
            
        }
    }

    
    
    //Function for when retweet button is pressed

    func onRetweet(){
        var id = tweet.id
        
        let idDictionary = ["id": id!]
        
        TwitterClient.sharedInstance.getTweetWithParams(idDictionary) { (tweet, error) -> () in
            self.tweet! = tweet!
            
        }
        
        id = self.tweet!.id
        
        
        if !tweet.retweetBool! {
            //var retweetCount = Int(self.retweetCountLabel.text!)
            
            
            tweet.retweetCount = tweet.retweetCount! + 1
           
            self.retweetCountLabel.text = "\(tweet.retweetCount!)"
            
            self.retweetBool = !tweet.retweetBool!
            
           
            
            TwitterClient.sharedInstance.retweetWithParams(idDictionary) { (id, error) -> () in
                
            }
            
            
             //retweetIcon.setImage(UIImage(named: "retweet-pressed"), forState: UIControlState.Normal)
            
            
        } else {
            
            
           // self.retweetCountLabel.text = "\(retweetCount!)"
            
            
            
                
        }
        }
        
        
    }
        
        
        // TwitterClient.sharedInstance.retweetWithParams(nil){
        // (id, error)-> () in

        
    
    


