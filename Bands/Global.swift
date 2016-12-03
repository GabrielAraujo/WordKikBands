//
//  Global.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import UIKit

//Global App delegate access
let AD = UIApplication.shared

//Global User Defaults access
let UD = UserDefaults.standard

let NC = NotificationCenter.default

let bgImages = [
    UIImage(named: "betwburriedandme"),
    UIImage(named: "cob"),
    UIImage(named: "death"),
    UIImage(named: "entombed"),
    UIImage(named: "greeday"),
    UIImage(named: "hypocrisi"),
    UIImage(named: "inflames"),
    UIImage(named: "linkin-park"),
]

var currentBgImage = bgImages[Int(arc4random_uniform(UInt32(bgImages.count)))]

let kChangeBgImage = "kChangeBgImage"

