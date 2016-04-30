//
//  ViewController.swift
//  SpotOn
//
//  Created by Cyril Montailler on 11/04/2016.
//  Copyright © 2016 Cyril Montailler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var followersLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func artistButton(sender: AnyObject) {
        
        requestArtist(year: 2000, country: "FR") {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.artistLabel.text = artistInfos.artists.first!.name
                let followers = artistInfos.artists.first!.followers
                self.followersLabel.text = String(followers)
            })
        }
    }

}

