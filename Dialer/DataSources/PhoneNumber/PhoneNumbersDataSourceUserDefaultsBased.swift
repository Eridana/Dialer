//
//  PhoneNumbersDataSourceUserDefaultsBased.swift
//  Dialer
//
//  Created by Женя Михайлова on 19.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

final class PhoneNumbersDataSourceUserDefaultsBased: PhoneNumbersDataSourceInterface {

    private var defaultsKeyName : String
    
    init(withDefaultsKey keyName : String) {
        defaultsKeyName = keyName
    }
    
    func save(array:[PhoneDomainModel]) -> Bool {
        return saveArrayToDefaultsWithKey(key: defaultsKeyName, array: array)
    }
    
    func load(_ result: @escaping (Result<[PhoneDomainModel]?, NSError>) -> ()) {
        if let array = arrayFromDefaultsWithKey(key: defaultsKeyName) as [PhoneEntity]? {
            if let convertedData = convertToModels(entities: array) as [PhoneDomainModel]? {
                result(.success(convertedData))
            } else {
                result(.failure(NSError(domain: "Failed to convert data", code: 1, userInfo: nil)))
            }
        } else {
            result(.success(nil))
        }
    }
    
    func createObjects(count: Int) -> [PhoneDomainModel]? {
        
        var arrayOfEntities = Array<PhoneEntity>()
        
        for index in 0...count - 1 {
            let entity = PhoneEntity(index: index, phoneNumber: nil, displayedName: nil, mapped: false)
            arrayOfEntities.append(entity)
        }
        
        guard let data  = convertToModels(entities: arrayOfEntities) else {
            return nil
        }
        
        return data
    }
    
    func convertToModels(entities : [PhoneEntity]?) -> [PhoneDomainModel]? {
        
        if let arrayOfEntities = entities {
            
            var domainModelArray = Array<PhoneDomainModel>()
            for item in arrayOfEntities {
                let domailModelItem = PhoneDomainModel(index: item.index, phoneNumber: item.phoneNumber, displayedName: item.displayedName, mapped: item.mapped)
                domainModelArray.append(domailModelItem)
            }
            return domainModelArray
        }
        return nil
    }
    
    func convertToEntities(models : [PhoneDomainModel]?) -> [PhoneEntity]? {
        
        if let arrayOfModels = models {
            
            var array = Array<PhoneEntity>()
            
            for item in arrayOfModels {
                let entityItem = PhoneEntity(index: item.index, phoneNumber: item.phoneNumber, displayedName: item.displayedName, mapped: item.mapped)
                array.append(entityItem)
            }
            return array
        }
        return nil
    }
    
    private func saveArrayToDefaultsWithKey(key : String, array: [PhoneDomainModel]) -> Bool {
        
        guard let data = convertToEntities(models: array) else {
            return false
        }
        return saveArrayToDefaultsWithKey(key: key, array: data)
    }
    
    private func saveArrayToDefaultsWithKey(key : String, array: [PhoneEntity]) -> Bool {
        
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(data, forKey: key)
        return true
    }
    
    
    private func arrayFromDefaultsWithKey(key: String) -> [PhoneEntity]? {
        
        var savedArray : [PhoneEntity]?

        let arrayData = UserDefaults.standard.value(forKey: key) as? Data
        
        guard let data = arrayData else {
            print("Data is nil")
            return nil
        }
        
        savedArray = NSKeyedUnarchiver.unarchiveObject(with: data) as? [PhoneEntity]
        return savedArray
    }
}
