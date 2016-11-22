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
    
}

//MARK: Output
protocol MainModuleInteractorOutput: class {
    func callPhoneNumber(number : String)
}

// MARK: - Interactor
final class MainModuleInteractor: MainModuleInteractorInput {
    weak var output: MainModuleInteractorOutput!
    weak var dataSource : PhoneNumbersDataSourceInterface!

    func possibleCallPhoneNumberFor(data: PhoneDomainModel) {
        if (data.mapped ?? false) {
            output.callPhoneNumber(number : data.phoneNumber!)
        }
    }
    
    func requestData(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ()) {
        dataSource.load { (loadedResult) in
            result(loadedResult)
//            switch loadedResult {
//                case .success(let data) : self.result.success(data)
//                case .failure(let error):
            }
    }
}


