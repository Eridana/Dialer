//
//  Theme.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

enum ThemeType {
    case Dark
    case Light
}

class Theme: NSObject {

    var currentTheme : ThemeType
    
    override init() {
        self.currentTheme = .Dark
        super.init()        
    }
    
    func setCurrentTheme(theme:ThemeType) {
        self.currentTheme = theme
    }
    
    func collectionBgColor() -> UIColor {
        return self.themeIsDark() ? Style.darkCollectionBgColor : Style.lightCollectionBgColor
    }
    
    func cellBgColor() -> UIColor {
        return self.themeIsDark() ? Style.darkCellBgColor : Style.lightCellBgColor
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
