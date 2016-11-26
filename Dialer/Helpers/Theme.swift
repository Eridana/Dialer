//
//  Theme.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

enum ThemeType : String {
    case Dark
    case Light
}

class Theme: NSObject {

    static let current = Theme()
    private var dataSource : ThemesDataSourceInterface!
    
    private(set) public var currentTheme : ThemeType
    
    override init() {
        self.dataSource = ThemesDataSource()
        self.currentTheme = dataSource.loadTheme()
        super.init()        
    }
    
    func setCurrentTheme(theme : ThemeType) {
        self.currentTheme = theme
        self.dataSource.saveTheme(theme: theme)
    }
    
    func barStyle() -> UIStatusBarStyle {
        return self.themeIsDark() ? .lightContent : .default
    }
    
    func collectionBgColor() -> UIColor {
        return self.themeIsDark() ? Style.darkCollectionBgColor : Style.lightCollectionBgColor
    }
    
    func mappedTextColor() -> UIColor {
        return self.themeIsDark() ? Style.darkMappedTextColor : Style.lightMappedTextColor
    }
    
    func notMappedTextColor() -> UIColor {
        return self.themeIsDark() ? Style.darkNotMappedTextColor : Style.lightNotMappedTextColor
    }
    
    func mappedBorderColor() -> UIColor {
        return self.themeIsDark() ? Style.darkMappedBorderColor : Style.lightMappedBorderColor
    }
    
    func notMappedBorderColor() -> UIColor {
        return self.themeIsDark() ? Style.darkNotMappedBorderColor : Style.lightNotMappedBorderColor
    }
    
    func mappedCellBgColor() -> UIColor {
        return self.themeIsDark() ? Style.darkMappedCellBgColor : Style.lightMappedCellBgColor
    }
    
    func notMappedCellBgColor() -> UIColor {
        return self.themeIsDark() ? Style.darkNotMappedCellBgColor : Style.lightNotMappedCellBgColor
    }
    
    func mainBackgroundImage() -> UIImage {
        let imageName = self.themeIsDark() ? Style.darkBackgroundImageName : Style.lightBackgroundImageName
        guard let image = UIImage(named: imageName) else {
            return UIImage()
        }
        return image
    }
    
    private func themeIsDark() -> Bool {
        switch currentTheme {
        case ThemeType.Dark:
            return true
        default:
            return false
        }
    }
}
