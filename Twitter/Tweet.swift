//
//  Tweet.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/5/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favouriteCount : Int?
    var retweetBool : Bool?
    var id: Int?
    var favoriteBool: Bool?
    
    init(dictionary : NSDictionary) {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        retweetCount = dictionary["retweet_count"] as! Int
        
        favouriteCount = dictionary["favorite_count"] as! Int
        favoriteBool = dictionary["favorited"] as! Bool
        
        retweetBool = dictionary["retweeted"] as! Bool
        id = dictionary["id"] as! Int
        
        var formatter = NSDateFormatter()
        
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        
        
        
    }
    class func tweetsWithArray(array: [NSDictionary])-> [Tweet]{
        var tweets = [Tweet]()
        for dictionary in array {
            tweets.append(Tweet(dictionary : dictionary))
        }
        
        return tweets
    }
}
