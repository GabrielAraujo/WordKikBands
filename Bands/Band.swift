//
//  Band.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import Gloss

class Band : Decodable {
    var id:Int?
    var name:String?
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
    
    required init?(json: JSON) {
        
    }
    
    class func getFromFile(completion: @escaping (Result<[Band]>) -> Void){
        do {
            if let path = Bundle.main.url(forResource: "bands", withExtension: "json"){
                let jsonData = try Data(contentsOf: path)
                let object = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    if let dictBands = dictionary["bands"] as? [[String: AnyObject]] {
                        var bands:[Band] = []
                        dictBands.forEach({
                            if let idString = $0["id"] as? String {
                                if let id = Int(idString) {
                                    if let name = $0["name"] as? String {
                                        bands.append(Band(id: id, name: name))
                                    }
                                }
                            }
                        })
                        completion(.success(bands))
                    }else{
                        completion(.failure(Errors.invalidJsonFormat))
                    }
                }else{
                    completion(.failure(Errors.invalidJsonFormat))
                }
            }else{
                completion(.failure(Errors.invalidJsonLocation))
            }
        } catch let e {
            completion(.failure(e))
        }
    }
}
