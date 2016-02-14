//
//  ComposeTweetViewController.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    var tweet: Tweet?
    
    @IBOutlet weak var tweetTextField: UITextView!
    @IBOutlet weak var charsTweet: UILabel!
    
    @IBAction func onTweet(sender: AnyObject) {
        
        
        
        
        var tweetText = tweetTextField.text as String?
        
        let tweetDict = ["status": tweetText!]
        if let tweet = tweet {
            let statusId = tweet.id!
            let screenname = tweet.user?.screenname!
            tweetText = "@\(screenname!) \(tweetText!)"
            let tweetDict = ["status": tweetText!, "in_reply_to_status_id": statusId]
            TwitterClient.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
                
            }}
        else{
        
        
        
        
        TwitterClient.sharedInstance.tweetWithParams(tweetDict) { (status, error) -> () in
            
                }}

        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        charsTweet.text = "\((tweetTextField.text.characters.count))"
        charsTweet.reloadInputViews()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
