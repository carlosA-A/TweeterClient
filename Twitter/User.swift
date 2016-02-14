//
//  User.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
    var name : String?
    var screenname: String?
    var profileImageUrl: NSURL?
    var tagline: String?
    var bannerImageUrl: String?
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
     
        
        
    var dictionary: NSDictionary?
    
    
    init(dictionary: NSDictionary) {
        
        
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = NSURL(string: (dictionary["profile_image_url"] as? String)!)
        
        tagline = dictionary["description"] as? String
        
        bannerImageUrl = dictionary["profile_banner_url"] as? String
        
        followerCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        tweetCount = dictionary["statuses_count"] as? Int
        
    }
    
    func logout(){
    
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
        
        
    
    }
    

    
    class var currentUser: User?{
        get{
        
        if _currentUser == nil{
        var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as! NSData?
        if data != nil {
        do{
        var dictionary = try NSJSONSerialization.JSONObjectWithData(data! , options: NSJSONReadingOptions(rawValue: 0))
        
        _currentUser = User(dictionary: dictionary as! NSDictionary)

    }catch let error as NSError{
        //handle error
        print("Error : \(error)")
        }

        
        }
        
        }
        
        return _currentUser
        }
        
        set(user){
            _currentUser = user
            if _currentUser != nil{
                do{
                    let data = try NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: NSJSONWritingOptions(rawValue: 0))
                    
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }catch let error as NSError{
                    //handle error
                    print("Error : \(error)")
                }
            }else{
            
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)

            }
            NSUserDefaults.standardUserDefaults().synchronize()

        
        }
    }

}
