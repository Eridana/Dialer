//
//  DarkTheme.swift
//  Dialer
//
//  Created by Женя Михайлова on 28.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class DarkTheme: StyleInterface {

    func topViewBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.3)
    }
    
    func collectionBackgroundColor() -> UIColor {
        return UIColor.clear
    }
    
    func mappedCellBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.2)
    }
    
    func notMappedCellBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.2)
    }
    
    func mappedTextColor() -> UIColor {
        return UIColor.white
    }
    
    func notMappedTextColor() -> UIColor {
        return UIColor.black
    }
    
    func mappedBorderColor() -> UIColor {
        return UIColor.clear
    }
    
    func notMappedBorderColor() -> UIColor {
        return UIColor.clear
    }
    
    func tableHeaderColor() -> UIColor {
        return UIColor.black.withAlphaComponent(0.1)
    }
    
    func backgroundImage() -> UIImage {
        return UIImage.init(named: "galaxy_bg1")!
    }
    
    func settingsBackgroundImage() -> UIImage {
        return UIImage.init(named: "galaxy_bg1")!
    }
    
    func mappedContactImage() -> UIImage {
        return UIImage.init(named: "contact_white")!
    }
    
    func notMappedContactImage() -> UIImage {
        return UIImage.init(named: "contact_black")!
    }
    
    func removeContactImage() -> UIImage {
        return UIImage.init(named: "removeCellButton")!
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func barStyle() -> UIBarStyle {
        return .default
    }
    
    func identifier() -> ThemeIdentifier {
        return .dark
    }
}
