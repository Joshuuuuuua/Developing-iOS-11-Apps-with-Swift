//
//  DemoURl.swift
//  Cassini
//
//  Created by Joshua on 2017/8/20.
//  Copyright © 2017年 Joshua. All rights reserved.
//

import Foundation

struct DemoURL
{
    static let stanford = Bundle.main.url(forResource: "oval", withExtension: "jpg")
    //static let stanford = URL(string: "http://s1.dgtle.com/forum/201708/19/094404vhc71tp1gcj7bt7l.jpg")
    static var NASA: Dictionary<String, URL> = {
        let NASAURLStrings = [
            "Cassini" : "https://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
            "Earth" : "https://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
            "Saturn" : "https://www.nasa.gov/sites/default/files/saturn_collage.jpg"
        ]
        var urls = Dictionary<String, URL>()
        for (key, value) in NASAURLStrings {
            urls[key] = URL(string: value)
        }
        return urls
    }()
}
