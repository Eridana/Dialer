//
//  MainModuleDataManager.swift
//  Dialer
//
//  Created by Женя Михайлова on 19.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

class MainModuleDataManager: NSObject, BaseDataManager {

    let defaultFileName = "savedData"
    
    func save(array:[BaseObject]) -> Bool {
        return saveArrayToFileWithName(fileName: defaultFileName, array: array)
    }
    
    func load(_ result: @escaping (Result<[BaseObject], NSError>) -> ()) {
        if let value = arrayFromContentsOfFileWithName(fileName: defaultFileName) as [BaseObject]? {
            result(.success(value))
        }
    }
    
    private func saveArrayToFileWithName(fileName : String, array: [BaseObject]) -> Bool {
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {

            do {
                let data = NSKeyedArchiver.archivedData(withRootObject: array)
                try data.write(to: fileURL)
            } catch {
                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
                return false
            }
        }
        
        return true
    }
    
    private func arrayFromContentsOfFileWithName(fileName: String) -> [BaseObject]? {
        
        var savedArray : [BaseObject]?
        
        let docDirectory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        if let fileURL = docDirectory?.appendingPathComponent(fileName).appendingPathExtension("txt") {
            savedArray = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.absoluteString) as? [BaseObject]
        }
        
        return savedArray
    }
}
