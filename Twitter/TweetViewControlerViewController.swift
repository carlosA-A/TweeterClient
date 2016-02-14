//
//  TweetViewControlerViewController.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/13/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetViewControlerViewController: UIViewController {
    var tweet: Tweet?
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var realNameLabel: UILabel!

    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImage.userInteractionEnabled = true
        
        realNameLabel.text = tweet?.user?.name
        userProfileImage.setImageWithURL((tweet?.user?.profileImageUrl)!)
        userNameLabel.text = tweet?.user?.screenname
        tweetLabel.text = tweet?.text
        favoriteCount.text = "\((tweet?.favouriteCount)!)"
        retweetCount.text = "\((tweet?.retweetCount)!)"
        
        //Format date
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM d HH:mm y"
        var dateString = dateFormatter.stringFromDate(tweet!.createdAt!)
        
        timeStampLabel.text = dateString
        
        
        
        // Do any additional setup after loading the view.
    }

    @IBAction func actionImage(sender: AnyObject) {
        print("It works")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //let cell = sender
        let tweet = self.tweet!
        
        if let detailsViewController = segue.destinationViewController as? UserDetailViewController{
        
        detailsViewController.tweet = tweet
        }
        else if let detailsViewController = segue.destinationViewController as? ComposeTweetViewController{
            
            detailsViewController.tweet = tweet
        }

    }
    

}
