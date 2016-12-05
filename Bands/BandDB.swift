//
//  BandDB.swift
//  Bands
//
//  Created by Gabriel Araujo on 04/12/16.
//  Copyright © 2016 Wordkik. All rights reserved.
//

import Foundation
import RealmSwift

class BandDB: Object {
    let id = RealmOptional<Int>()
    dynamic var name:String?
    
    //Downloadable Data
    dynamic var genre:String?
    dynamic var imageUrl:String?
    dynamic var country:String?
    dynamic var countryFlagUrl:String?
    dynamic var website:String?
    
    //Flag
    let fetched = RealmOptional<Bool>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    class func get(_ id: Int, completion: (Result<Band>) -> Void) {
        do {
            let realm = try Realm()
            let lang = realm.objects(BandDB.self).filter("id == %@", id).first
            if let lan = lang {
                completion(.success(BandDB.dbToObj(lan)))
            }else{
                //TODO Raise Error of invalid
                completion(.failure(Errors.noObjInLocalDb))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    class func dbToObj(_ db:BandDB) -> Band {
        let obj = Band()
        obj.id = db.id.value
        obj.name = db.name
        obj.genre = db.genre
        obj.imageUrl = db.imageUrl
        obj.country = db.country
        obj.countryFlagUrl = db.countryFlagUrl
        obj.website = db.website
        obj.fetched = db.fetched.value
        
        return obj
    }
    
    fileprivate func updateValues(_ current:Band){
        if id.value == nil {
            id.value = current.id
        }
        name = current.name
        genre = current.genre
        imageUrl = current.imageUrl
        country = current.country
        countryFlagUrl = current.countryFlagUrl
        website = current.website
        fetched.value = current.fetched
    }
}
