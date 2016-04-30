//
//  SpotRequest.swift
//  SpotOn
//
//  Created by Cyril Montailler on 18/04/2016.
//  Copyright © 2016 Cyril Montailler. All rights reserved.
//

import Foundation

var number: Int?
var artistInfos: SpotFeed!

func requestArtist(year newYear: Int, country newCountry: String, completion: () -> ()) {
    //url to find total number
    let urlString = "https://api.spotify.com/v1/search?q=year%3A\(newYear)&type=artist&market=\(newCountry)"
    let requestArtistsNumberUrl = NSURL(string: urlString)
    findAnArtist(requestArtistsNumberUrl!) {
        print("done")
        completion()
    }
}

func findAnArtist (urlString: NSURL, completion: () -> ()) {

    let task = NSURLSession.sharedSession().dataTaskWithURL(urlString) { (data, response, error) -> Void in
        if error == nil && data != nil {
            number = readArtistsNumber(data!)
            print(number)
            // Define a test if number not nil and >0
            let requestArtistUrl = defineRequestArtistUrl(urlString, number: number!)
            
            let secondtask = NSURLSession.sharedSession().dataTaskWithURL(requestArtistUrl) { (data, response, error) -> Void in
                if error == nil && data != nil {

                    artistInfos = SpotFeed(data: data!, sourceURL: requestArtistUrl)
                    print(artistInfos?.artists.first?.name)
                    print(artistInfos?.artists.first?.followers)
                    print(artistInfos?.artists.first?.id)
                    print(artistInfos?.artists.first?.genres)
                    print(artistInfos?.artists.count)
                    for index in 0..<artistInfos.artists.count {
                        print(artistInfos.artists[index].name)
                    }
                    completion()
                    
                } else {
                    print("error2")
                }
            }
            secondtask.resume()
            } else {
            print("error")
            }
        }
        task.resume()
    }

func readArtistsNumber (data: NSData) -> Int {
    var jsonObject: Dictionary<String, AnyObject>?
    do {
        jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject>
    } catch {
        //TODO
    }
    guard let total = jsonObject!["artists"]!["total"] as? Int else {
        return 0
    }
    return total
}

func readArtistInfos (data: NSData) -> Dictionary<String, AnyObject> {
    var jsonObject: Dictionary<String, AnyObject>?
    do {
        jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String, AnyObject>
    } catch {
        //TODO
    }
    return jsonObject!
}

func defineRequestArtistUrl (urlFirst: NSURL, number: Int) -> NSURL {
    // Find artist randomly
    let offset = (arc4random_uniform(UInt32(number)))
    let urlString = urlFirst.absoluteString
    let appendString = urlString + "&limit=1&offset=\(offset)"
    let requestArtistUrl = NSURL(string: appendString)
    
    return requestArtistUrl!
}