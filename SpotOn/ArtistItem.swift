//
//  ArtistItem.swift
//  SpotOn
//
//  Created by Cyril Montailler on 21/04/2016.
//  Copyright © 2016 Cyril Montailler. All rights reserved.
//

import Foundation

struct FollowersObject {
    let href: NSURL
    let total: Int
}

struct ImageObject {
    let height: Int
    let url: NSURL
    let width: Int
}

struct ArtistItem {
    let followers: Int
    let genres: [String]
    let href: NSURL
    let id: String
    //let images: [ImageObject]
    let name: String
    let popularity: Int
}