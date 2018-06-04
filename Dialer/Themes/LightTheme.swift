//
//  LightTheme.swift
//  Dialer
//
//  Created by Женя Михайлова on 28.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class LightTheme: StyleInterface {
    
    func topViewBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.6)
    }
    
    func collectionBackgroundColor() -> UIColor {
        return UIColor.clear
    }
    
    func mappedCellBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.45)
    }
    
    func notMappedCellBackgroundColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.45)
    }
    
    func mappedTextColor() -> UIColor {
        return UIColor.black
    }
    
    func notMappedTextColor() -> UIColor {
        return UIColor.black.withAlphaComponent(0.4)
    }
    
    func mappedBorderColor() -> UIColor {
        return UIColor.clear
    }
    
    func notMappedBorderColor() -> UIColor {
        return UIColor.clear
    }
    
    func tableHeaderColor() -> UIColor {
        return UIColor.white.withAlphaComponent(0.35)
    }
    
    func backgroundImage() -> UIImage {
        return UIImage.init(named: "light_bg1")!
    }
    
    func settingsBackgroundImage() -> UIImage {
        return UIImage.init(named: "light_bg2")!
    }
    
    func mappedContactImage() -> UIImage {
        return UIImage.init(named: "contact_black")!
    }
    
    func notMappedContactImage() -> UIImage {
        return UIImage.init(named: "contact_white")?.imageWithTintColor(notMappedTextColor()) ?? UIImage()
    }
    
    func removeContactImage() -> UIImage {
        return UIImage.init(named: "removeCellButton")?.imageWithTintColor(mappedTextColor()) ?? UIImage()
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        return .default
    }
    
    func barStyle() -> UIBarStyle {
        return .default
    }
    
    func identifier() -> ThemeIdentifier {
        return .light
    }
}
