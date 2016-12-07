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
    
    class func save(_ band:Band, completion: (Result<Band>) -> Void){
        do {
            let realm = try Realm()
            let objF = realm.objects(BandDB.self).filter("id == %@", band.id!).first
            if let objDb = objF {
                try realm.write {
                    objDb.updateValues(band)
                    realm.add(objDb, update: true)
                }
                completion(.success(BandDB.dbToObj(objDb)))
            }else{
                let objDb = BandDB()
                try realm.write {
                    objDb.updateValues(band)
                    realm.add(objDb)
                }
                completion(.success(BandDB.dbToObj(objDb)))
            }
            NC.post(name: Notification.Name(rawValue: kAddedBand), object: nil)
        } catch let error as NSError {
            completion(.failure(error))
        }
    }
    
    class func get(_ id: Int, completion: (Result<Band>) -> Void) {
        do {
            let realm = try Realm()
            let band = realm.objects(BandDB.self).filter("id == %@", id).first
            if let ban = band {
                completion(.success(BandDB.dbToObj(ban)))
            }else{
                //TODO Raise Error of invalid
                completion(.failure(Errors.noObjInLocalDb))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    class func get(_ completion: (Result<[Band]>) -> Void) {
        do {
            let realm = try Realm()
            let bands = realm.objects(BandDB.self)
            completion(.success(bands.map({ BandDB.dbToObj($0) })))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    class func getFetched(_ completion: (Result<[Band]>) -> Void) {
        do {
            let realm = try Realm()
            let bands = realm.objects(BandDB.self).filter("fetched == true")
            completion(.success(bands.map({ BandDB.dbToObj($0) })))
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
    
    class func objToDb(_ obj:Band) -> BandDB {
        let db = BandDB()
        db.id.value = obj.id
        db.name = obj.name
        db.genre = obj.genre
        db.imageUrl = obj.imageUrl
        db.country = obj.country
        db.countryFlagUrl = obj.countryFlagUrl
        db.website = obj.website
        db.fetched.value = obj.fetched
        
        return db
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
