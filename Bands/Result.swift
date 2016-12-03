//
//  Result.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
