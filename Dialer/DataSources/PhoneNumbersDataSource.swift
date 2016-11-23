//
//  PhoneNumbersDataSource.swift
//  Dialer
//
//  Created by Женя Михайлова on 19.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

protocol PhoneNumbersDataSourceInterface: class {
    func save(array:[PhoneDomainModel]) -> Bool;
    func load(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ());
    func createObjects(count : Int) -> [PhoneDomainModel]?
}

class PhoneNumbersDataSource: NSObject, PhoneNumbersDataSourceInterface {

    let defaultFileName = "savedData"
    
    func save(array:[PhoneDomainModel]) -> Bool {
        return saveArrayToFileWithName(fileName: defaultFileName, array: array)
    }
    
    func load(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ()) {
        if let array = arrayFromContentsOfFileWithName(fileName: defaultFileName) as [PhoneEntity]? {
            if let convertedData = convertToModels(entities: array) as [PhoneDomainModel]? {
                result(.success(convertedData))
            } else {
                result(.failure(NSError(domain: "Failed to convert data", code: 1, userInfo: nil)))
            }
        } else {
            result(.failure(NSError(domain: "No such data in file", code: 1, userInfo: nil)))
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
    
    private func saveArrayToFileWithName(fileName : String, array: [PhoneDomainModel]) -> Bool {
        
        guard let data = convertToEntities(models: array) else {
            return false
        }
        return saveArrayToFileWithName(fileName: fileName, array: data)
    }
    
    private func saveArrayToFileWithName(fileName : String, array: [PhoneEntity]) -> Bool {
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            do {
                let data = NSKeyedArchiver.archivedData(withRootObject: array)
                try data.write(to: fileURL)
            } catch {
                print("Failed writing to path: \(fileURL), Error: " + error.localizedDescription)
                return false
            }
        }
        
        return true
    }
    
    private func arrayFromContentsOfFileWithName(fileName: String) -> [PhoneEntity]? {
        
        var savedArray : [PhoneEntity]?
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            
            do {
                let arrayData = try Data(contentsOf: fileURL)
                savedArray = NSKeyedUnarchiver.unarchiveObject(with: arrayData) as? [PhoneEntity]
            } catch {
                print("Failed reading from path: \(fileURL), Error: " + error.localizedDescription)
                return nil;
            }            
        }
        
        return savedArray
    }
}