//
//  SpotFeed.swift
//  SpotOn
//
//  Created by Cyril Montailler on 17/04/2016.
//  Copyright © 2016 Cyril Montailler. All rights reserved.
//

import Foundation

class SpotFeed {
    
    let artists: [ArtistItem]
    //let limit: Int
    //let next: NSURL
    //let offset: Int
    //let previous: NSURL
    //let total: Int
    
    let sourceURL: NSURL
    
    
    init (artists newArtists: [ArtistItem], sourceURL newUrl: NSURL) {
        self.artists = newArtists
        //self.limit = limit
        //self.next = next
        //self.offset = offset
        //self.previous = previous
        //self.total = total
        self.sourceURL = newUrl
    }
    
    convenience init? (data: NSData, sourceURL: NSURL) {
        
        var newArtists = [ArtistItem]()
        
        var jsonObject: Dictionary<String, AnyObject>?
        
        do {
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String,AnyObject>
        } catch {
            
        }
        
        guard let spotRoot = jsonObject else {
            return nil
        }
        
        
        guard let artists = spotRoot["artists"]?["items"] as? Array<AnyObject> else {
            return nil
        }
        
       /* guard let artists = root["items"] as? Array<AnyObject> else {
            return nil
        }*/
        
        for artist in artists {
            guard let artistDict = artist as? Dictionary<String, AnyObject> else {
                continue
            }
            
            // To continue
            guard let followersDict = artistDict["followers"] as? Dictionary<String, AnyObject> else {
                continue
            }
            
            guard let followers = followersDict["total"] as? Int else {
                continue
            }
            
            guard let genres = artist["genres"] as? [String] else {
                continue
            }
            
            guard let hrefRaw = artist["href"] as? String else {
                continue
            }
            
            guard let href = NSURL(string: hrefRaw) else {
                continue
            }
            
            guard let id = artist["id"] as? String else {
                continue
            }
            
            //images to implement
            
            guard let name = artist["name"] as? String else {
                continue
            }
            
            guard let popularity = artist["popularity"] as? Int else {
                continue
            }
            
            newArtists.append(ArtistItem(followers: followers, genres: genres, href: href, id: id, name: name, popularity: popularity))
            
        }
        
        self.init(artists: newArtists, sourceURL: sourceURL)
        //super.init()
    }
}