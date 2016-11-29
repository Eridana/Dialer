//
//  DarkTheme.swift
//  Dialer
//
//  Created by Женя Михайлова on 28.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class DarkTheme: StyleInterface {

    func collectionBackgroundColor() -> UIColor {
        return UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.25)
    }
    
    func mappedCellBackgroundColor() -> UIColor {
        return UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    }
    
    func notMappedCellBackgroundColor() -> UIColor {
        return UIColor.init(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    }
    
    func mappedTextColor() -> UIColor {
        return UIColor.white
    }
    
    func notMappedTextColor() -> UIColor {
        return UIColor.init(red: 66.0/255.0, green: 66.0/255.0, blue: 73.0/255.0, alpha: 1.0)
    }
    
    func mappedBorderColor() -> UIColor {
        return UIColor.white
    }
    
    func notMappedBorderColor() -> UIColor {
        return UIColor.init(red: 66.0/255.0, green: 66.0/255.0, blue: 73.0/255.0, alpha: 1.0)
    }
    
    func backgroundImage() -> UIImage {
        return UIImage.init(named: "darkBackground")!
    }
    
    func statusBarStyle() -> UIStatusBarStyle {
        return .lightContent
    }
    
    func identifier() -> ThemeIdentifier {
        return .dark
    }
}
