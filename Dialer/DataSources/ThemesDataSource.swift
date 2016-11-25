//
//  ThemesDataSource.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class ThemesDataSource: NSObject, ThemesDataSourceInterface {

    let defaultsKeyName = "savedTheme"
    
    func themeDidSelect(theme : ThemeType) {
        Theme.current.setCurrentTheme(theme: theme)
        self.saveTheme(theme: theme)
    }
    
    func saveTheme(theme: ThemeType) {
        self.saveThemeInDefaults(theme: theme, forKey : defaultsKeyName)
    }
    
    func loadTheme() -> ThemeType {
        return loadSavedTheme(forKey : defaultsKeyName)
    }
    
    private func saveThemeInDefaults(theme : ThemeType, forKey key : String) {
        UserDefaults.standard.set(theme.rawValue, forKey: key)
    }
    
    private func loadSavedTheme(forKey key : String) -> ThemeType {
        let value = UserDefaults.standard.value(forKey: key) as? String
        if value != nil {
            return ThemeType(rawValue: value!)!
        }
        return ThemeType.Dark
    }
}
