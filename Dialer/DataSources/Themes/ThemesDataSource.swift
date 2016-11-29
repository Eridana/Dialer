//
//  ThemesDataSource.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class ThemesDataSource: NSObject, ThemesDataSourceInterface {

    private let defaultsKeyName = "savedTheme"
    private let defaultTheme = DarkTheme()
    private var selectedTheme : StyleInterface?
    
    func currentTheme() -> StyleInterface {
        guard let theme = selectedTheme else {
            return loadSavedTheme(forKey: defaultsKeyName)
        }
        return theme
    }
    
    func setCurrentThemeBy(identifier : ThemeIdentifier) {
        selectedTheme = themeByIdentifier(identifier: identifier)
        self.saveTheme(theme: selectedTheme!)
    }
    
    private func saveTheme(theme: StyleInterface) {
        self.saveThemeInDefaults(theme: theme, forKey : defaultsKeyName)
    }
    
    private func loadTheme() -> StyleInterface {
        return loadSavedTheme(forKey : defaultsKeyName)
    }
    
    private func saveThemeInDefaults(theme : StyleInterface, forKey key : String) {
        UserDefaults.standard.set(theme.identifier().rawValue, forKey: key)
    }
    
    private func loadSavedTheme(forKey key : String) -> StyleInterface {
        let value = UserDefaults.standard.value(forKey: key) as? String
        guard let existingValue = value else {
            return defaultTheme
        }
        let identifier = ThemeIdentifier(rawValue: existingValue)!
        return themeByIdentifier(identifier: identifier)
    }
    
    private func themeByIdentifier(identifier : ThemeIdentifier) -> StyleInterface {
        switch identifier {
        case .light:
            return LightTheme()
        default:
            return defaultTheme
        }
    }
}
