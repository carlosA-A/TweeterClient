//
//  TweetsViewControlerViewController.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/6/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TweetsViewControlerViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var tweets: [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBAction func onRetweet(sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "@" + (User.currentUser?.name)!

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser!.logout()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets!.count
        }
        else{
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath:  indexPath) as! TweetTableViewCell
        
        
        
        cell.tweet = tweets![indexPath.row]        
        
        
        
        return cell
    }
    
    func onRetweet(){
    
    
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
