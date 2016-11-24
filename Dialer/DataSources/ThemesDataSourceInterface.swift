//
//  ThemesDataSourceInterface.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

protocol ThemesDataSourceInterface: class {
    func loadTheme() -> ThemeType
    func saveTheme(theme : ThemeType)
}
