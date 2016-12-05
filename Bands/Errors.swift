//
//  Errors.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation

enum Errors : Error {
    case invalidJsonFormat
    case invalidJsonLocation
    case noJsonResponse
    case couldNotInitializeBand
    case noObjInLocalDb
    
}
