//
//  LightTheme.swift
//  Dialer
//
//  Created by Женя Михайлова on 28.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class LightTheme: StyleInterface {
    
    func collectionBackgroundColor() -> UIColor {
        return UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.25)
    }
    
    func mappedCellBackgroundColor() -> UIColor {
        return UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
    }
    
    func notMappedCellBackgroundColor() -> UIColor {
        return UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 0.5)
    }
    
    func mappedTextColor() -> UIColor {
        return UIColor.black
    }
    
    func notMappedTextColor() -> UIColor {
        return UIColor.init(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    
    func mappedBorderColor() -> UIColor {
        return UIColor.black
    }
    
    func notMappedBorderColor() -> UIColor {
        return UIColor.init(red: 150.0/255.0, green: 150.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    
    func backgroundImage() -> UIImage {
        return UIImage.init(named: "lightBackground")!
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        return .default
    }
    
    func identifier() -> ThemeIdentifier {
        return .light
    }
}
