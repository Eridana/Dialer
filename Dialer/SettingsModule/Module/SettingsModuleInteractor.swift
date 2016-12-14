//
//  SettingsModuleInteractor.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

// MARK: - Interface
protocol SettingsModuleInteractorInput: class {
    func setNameDisplayStyle(style : NameDisplayStyle)
}

//MARK: Output
protocol SettingsModuleInteractorOutput: class {
    
}

// MARK: - Interactor
final class SettingsModuleInteractor: SettingsModuleInteractorInput {
    weak var output: SettingsModuleInteractorOutput!
    var settingsDataSource : SettingsDataSourceInterface!
    var settingsModel : SettingsDomainModel?
    
    func loadSettings(_ result: @escaping (Result<SettingsDomainModel?, NSError>) -> ()) {
        settingsDataSource.load({ (result) in
            
        })
    }
    
    func setNameDisplayStyle(style: NameDisplayStyle) {
        if var settings = settingsModel {
            settings.style = style
            settingsDataSource.save(settings)
        }
    }
}

