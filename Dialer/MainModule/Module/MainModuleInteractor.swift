//
//  MainModuleInteractor.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

// MARK: - Interface
protocol MainModuleInteractorInput: class {
    func possibleCallPhoneNumberFor(data : PhoneDomainModel)
    func requestData(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ())
    func setDataSource(dataSource : PhoneNumbersDataSourceInterface)
    func removeItemMapping(phoneItem : PhoneDomainModel)
    func shouldPresentContactsScreenFor(phoneItem : PhoneDomainModel) -> Bool
    func updateContactWith(name : String, surname : String, phoneNumber : String, atIndex : Int)
}

//MARK: Output
protocol MainModuleInteractorOutput: class {
    func callPhoneNumber(number : String)
    func openContacts()
    func updateWith(data : [PhoneDomainModel])
}

// MARK: - Interactor
final class MainModuleInteractor: MainModuleInteractorInput {
    weak var output: MainModuleInteractorOutput!
    var dataSource : PhoneNumbersDataSourceInterface!
    var data : [PhoneDomainModel]?
    
    func setDataSource(dataSource: PhoneNumbersDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    func possibleCallPhoneNumberFor(data: PhoneDomainModel) {
        if (data.mapped) {
            output.callPhoneNumber(number : data.phoneNumber!)
        }
    }
    
    func requestData(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ()) {
        dataSource.load { (loadedResult) in
            
            switch loadedResult {
                
            case .success(let savedData) :
                
                if savedData != nil {
                    self.data = savedData
                    result(.success(savedData!))
                }
                else if let createdObjects = self.createObjects() {
                    self.data = createdObjects
                    result(.success(createdObjects))
                }
                
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func createObjects() -> [PhoneDomainModel]? {
        let count = 12
        let objects = dataSource?.createObjects(count: count)
        let saved = dataSource?.save(array: objects!)
        return saved ?? false ? objects : nil
    }
    
    func shouldPresentContactsScreenFor(phoneItem : PhoneDomainModel) -> Bool {
        return !phoneItem.mapped
    }
    
    func updateContactWith(name : String, surname : String, phoneNumber : String, atIndex : Int) {
        
        let filtered = data?.filter() { $0.index == atIndex }
        let item = filtered?.first
        if item != nil {
            item?.displayedName = "\(name) \(surname)"
            item?.phoneNumber = phoneNumber
            item?.mapped = true
        }
        let _ = dataSource?.save(array: data!)
        output.updateWith(data: data!)
    }
    
    func removeItemMapping(phoneItem : PhoneDomainModel) {
        phoneItem.displayedName = ""
        phoneItem.phoneNumber = ""
        phoneItem.mapped = false
        let _ = dataSource?.save(array: data!)
        output.updateWith(data: data!)
    }
}


