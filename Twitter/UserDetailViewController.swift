//
//  UserDetail.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/14/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var tweet: Tweet?
    
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var backgroundImageImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realNameLabel.text = tweet?.user?.name
        userNameLabel.text = "@\((tweet?.user?.screenname)!)"
        profilePictureImageView.setImageWithURL((tweet?.user?.profileImageUrl)!)
        overviewLabel.text = tweet?.user?.tagline
        backgroundImageImageView.setImageWithURL(NSURL(string: (tweet?.user?.bannerImageUrl)!)! )
        followingCount.text = "\((tweet?.user?.followingCount)!)"
        followersCount.text = "\((tweet?.user?.followerCount)!)"
        
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
