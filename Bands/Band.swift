//
//  Band.swift
//  Bands
//
//  Created by Gabriel Araujo on 03/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import Gloss
import RealmSwift
import Realm

class Band : Decodable {
    var id:Int?
    var name:String?
    
    //Downloadable Data
    var genre:String?
    var imageUrl:String?
    var country:String?
    var countryFlagUrl:String?
    var website:String?
    
    //Flag
    var fetched:Bool?
    
    init() {
        
    }
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
    
    required init?(json: JSON) {
        self.genre = "genre" <~~ json
        self.name = "name" <~~ json
        self.imageUrl = "image" <~~ json
        self.country = "country" <~~ json
        self.countryFlagUrl = "country_flag" <~~ json
        self.website = "website" <~~ json
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
    
    class func get(_ id: Int, completion: @escaping (Result<Band>) -> Void){
        BandDB.get(id, completion: {
            result in
            switch result {
            case .success(let band):
                completion(.success(band))
                break
            case .failure(let error):
                if error == Errors.noObjInLocalDb {
                    BandService().get(id, completion: {
                        result in
                        switch result {
                        case .success(let band):
                            band.fetched = true
                            band.save({
                                result in
                                switch result {
                                case .success( _):
                                    completion(.success(band))
                                    break
                                case .failure(let error):
                                    completion(.failure(error))
                                    break
                                }
                            })
                            break
                        case .failure(let error):
                            completion(.failure(error))
                            break
                        }
                    })
                }else{
                    completion(.failure(error))
                }
                break
            }
        })
    }
    
    class func getAll(_ completion: @escaping (Result<[Band]>) -> Void){
        BandDB.get(completion)
    }
    
    class func fetchAll() {
        Band.getFromFile(completion: {
            result in
            switch result {
            case .success(let fileBands):
                BandDB.getFetched({
                    result in
                    switch result {
                    case .success(let fetchedBands):
                        let filteredIds = fileBands.map({ $0.id! }).filter({ !fetchedBands.map({ $0.id! }).contains($0) })
                        filteredIds.forEach({
                            obj in
                            Band.get(obj, completion: {
                                result in
                                switch result {
                                case .success(let band):
                                    print("Fetched band \(band.id) \(band.name)")
                                    break
                                case .failure(let error):
                                    print("Could not fetch one band: \(error)")
                                    break
                                }
                            })
                        })
                        break
                    case .failure(let error):
                        print("Could not get fetched bands: \(error)")
                        break
                    }
                })
                break
            case .failure(let error):
                print("Could not get bands from file: \(error)")
                break
            }
        })
    }
    
    func save(_ completion: @escaping (Result<Bool>) -> Void){
        BandDB.save(self, completion: {
            result in
            switch result {
            case .success( _):
                completion(.success(true))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        })
    }
}
