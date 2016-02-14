//
//  TwitterClient.swift
//  Twitter
//
//  Created by Carlos Avogadro on 2/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey="zE1eCuN7h5ssxJeK8zu5VtZQ3"
let twitterConsumerSecret = "vuXW6rzJDikxr70k1FEWr57MA4ImFRB2Lz6vQ3osTYCF9DbglT"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    var loginCompletion : ((user: User?, error: NSError?)->())?
    
    class var sharedInstance : TwitterClient{
        struct Static {
            static let instance =     TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret:twitterConsumerSecret )

        }
    return Static.instance
    }
    
    
    
        
    func favoriteWithParams(params : NSDictionary,completion:(id: Int?, error:NSError?)->())
    {
        POST("1.1/favorites/create.json", parameters: params, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
        let id = params["id"] as! Int
            completion(id:id, error: nil)
            
            }) { (operation: NSURLSessionDataTask?, error: NSError)-> Void in
                completion(id:nil, error: error)
        
        
        }}
    


    
    func retweetWithParams(params: NSDictionary?, completion: (id: Int?, error: NSError?) -> ()) {
        let id = params!["id"] as! Int
        
        
        
        POST("1.1/statuses/retweet/\(id).json", parameters: params, progress: { (operation: NSProgress) -> Void in
            
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let id = params!["id"] as? Int
                //print("retweet response: \(response)")
                completion(id: id, error: nil)
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                //print("retweet error: \(error)")
                completion(id: nil, error: error)
        }
    }
    
    func getTweetWithParams(params: NSDictionary?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        let id = params!["id"] as! Int
        print(id)
        GET("1.1/statuses/show/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            let tweet = Tweet(dictionary: response as! NSDictionary)
            
            print(response as! NSDictionary)
            completion(tweet: tweet, error: nil)
            //print("tweet \(response)")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print("failure to get tweet")
                
                completion(tweet: nil, error: error)
        })
        
        
        
    }

    
    func homeTimelineWithParams(params:NSDictionary?,completion: (tweets:[Tweet]?,error : NSError?) ->()){
    
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
           // for tweet in tweets{
            //    print("text \(tweet.text), created \(tweet.createdAt)")
            //}
            completion(tweets: tweets, error: nil )
            
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
                print("It did not work")
                self.loginCompletion?(user:nil, error : error)
                completion(tweets: nil, error: NSError?.self as? NSError)
        })

    
    
    }
    
    
    func loginWithCompletion(completion : (user: User?, error: NSError?)->()){
    
    loginCompletion = completion
    
        //Get request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) { (error: NSError!) -> Void in
                print("Error getting request token: \(error)")
        }
    
    
    }
    
    func openURL(url: NSURL){
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got access token")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("It worked!!!")
                //print(response)
                
                //User is loging in
                var user = User(dictionary: response as! NSDictionary)
                
                User.currentUser = user
                
                print("user \(user.name)")
                self.loginCompletion!(user:user, error:nil)
                
                
                }, failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                    print("It did not work")
                    
                    self.loginCompletion?(user:nil, error : error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("An error occurred")
                self.loginCompletion?(user:nil, error : error)
        }

    
    
    }

}
