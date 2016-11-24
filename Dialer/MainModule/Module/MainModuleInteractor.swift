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
    func switchThemeFor(index: Int)
    func saveCurrentTheme()
    func loadSavedTheme()
}

//MARK: Output
protocol MainModuleInteractorOutput: class {
    func callPhoneNumber(number : String)
    func reloadTheme()
}

// MARK: - Interactor
final class MainModuleInteractor: MainModuleInteractorInput {
    weak var output: MainModuleInteractorOutput!
    var dataSource : PhoneNumbersDataSourceInterface!
    var themesDataSource : ThemesDataSourceInterface!
    
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
                
            case .success(let data) :
                
                if data != nil {
                    result(.success(data!))
                }
                else if let createdObjects = self.createObjects() {
                    result(.success(createdObjects))
                }
                
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func createObjects() -> [PhoneDomainModel]? {
        let count = 12
        let data = self.dataSource?.createObjects(count: count)
        let saved = self.dataSource?.save(array: data!)
        return saved ?? false ? data : nil
    }
    
    func switchThemeFor(index: Int) {
        if index == 0 {
            Theme.current.setCurrentTheme(theme: .Dark);
        } else {
            Theme.current.setCurrentTheme(theme: .Light);
        }
        self.saveCurrentTheme()
        self.output?.reloadTheme()
    }
    
    func saveCurrentTheme() {
        self.themesDataSource?.saveTheme(theme: Theme.current.currentTheme)
    }
    
    func loadSavedTheme() {
        if let theme = themesDataSource?.loadTheme() {
            Theme.current.setCurrentTheme(theme: theme)
        }
        self.output?.reloadTheme()
    }
}


