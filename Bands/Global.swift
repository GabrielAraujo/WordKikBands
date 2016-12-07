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

var bgImages:[UIImage] = []
var bgImagesId:[Int] = []

var currentBgImage:UIImage!

let kChangeBgImage = "kChangeBgImage"

let kAddedBand = "kAddedBand"

