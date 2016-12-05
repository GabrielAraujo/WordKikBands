//
//  BandService.swift
//  Bands
//
//  Created by Gabriel Araujo on 04/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class BandService : Gettable {
    func get(_ id: Int, completion: @escaping (Result<Band>) -> Void) {
        let url = "https://powerful-oasis-33182.herokuapp.com/bands/\(id)"
        
        Alamofire.request(url).responseJSON { response in
            print(response.result)
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json.dictionaryObject {
                    if let band = Band(json: data) {
                        band.id = id
                        completion(.success(band))
                    }else{
                        completion(.failure(Errors.couldNotInitializeBand))
                    }
                }else{
                    completion(.failure(Errors.couldNotInitializeBand))
                }
            }else{
                completion(.failure(Errors.noJsonResponse))
            }
        }
    }
}
