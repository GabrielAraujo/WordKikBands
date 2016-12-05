//
//  ServiceProtocol.swift
//  Bands
//
//  Created by Gabriel Araujo on 04/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation

protocol Gettable {
    associatedtype S
    
    func get(_ id: Int, completion: @escaping (Result<S>) -> Void)
}
