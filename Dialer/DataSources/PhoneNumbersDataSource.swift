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
                //result(.failure( ))
            }
        } else {
            //result(.failure( ))
        }
    }
    
    func convertToModels(entities : [PhoneEntity]?) -> [PhoneDomainModel]? {
        
        guard let array = arrayFromContentsOfFileWithName(fileName: defaultFileName) as [PhoneEntity]? else {
            return nil
        }
        
        var domainModelArray = Array<PhoneDomainModel>()
        for item in array {
            let domailModelItem = PhoneDomainModel(index: item.index, phoneNumber: item.phoneNumber, displayedName: item.displayedName, mapped: item.mapped)
            domainModelArray.append(domailModelItem)
        }
        return domainModelArray
    }
    
    func convertToEntities(models : [PhoneDomainModel]?) -> [PhoneEntity]? {
        
        if let arrayOfEntities = models {
            
            var array = Array<PhoneEntity>()
            
            for item in arrayOfEntities {
                let entityItem = PhoneEntity(index: item.index, phoneNumber: item.phoneNumber, displayedName: item.displayedName, mapped: item.mapped)
                array.append(entityItem)
            }
            return array
        }
        return nil
    }
    
    private func saveArrayToFileWithName(fileName : String, array: [PhoneDomainModel]) -> Bool {
        
        guard let convertedData = convertToEntities(models: array) else {
            return false
        }
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {

            do {
                let data = NSKeyedArchiver.archivedData(withRootObject: convertedData)
                try data.write(to: fileURL)
            } catch {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
                return false
            }
        }
        
        return true
    }
    
    private func arrayFromContentsOfFileWithName(fileName: String) -> [PhoneEntity]? {
        
        var savedArray : [PhoneEntity]?
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            savedArray = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.absoluteString) as? [PhoneEntity]
        }
        
        return savedArray
    }
}
