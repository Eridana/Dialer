//
//  SettingsDataSourceUserDefaultsBased.swift
//  Dialer
//
//  Created by Женя Михайлова on 04.12.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

enum NameDisplayStyle : String {
    case firstThenLast
    case lastThenFirst
    case firstNameOnly
}

final class SettingsDataSourceUserDefaultsBased: SettingsDataSourceInterface {

    private var defaultsKeyName : String
    
    init(withDefaultsKey keyName : String) {
        defaultsKeyName = keyName
    }
    
    func load(_ result: @escaping (Result<SettingsDomainModel?, NSError>) -> ()) {
        
    }
    
    func save(_ settingsModel: SettingsDomainModel) {
        
    }
    
    private func save() {
        
    }
    
}
