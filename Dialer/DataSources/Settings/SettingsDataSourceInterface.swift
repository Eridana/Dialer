//
//  SettingsDataSourceInterface.swift
//  Dialer
//
//  Created by Женя Михайлова on 04.12.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit
import Result

protocol SettingsDataSourceInterface: class {
    func save(_ settingsModel : SettingsDomainModel)
    func load(_ result: @escaping (Result<SettingsDomainModel?, NSError>) -> ());
}
