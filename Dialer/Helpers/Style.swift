//
//  Style.swift
//  Dialer
//
//  Created by Женя Михайлова on 24.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

struct Style {
    
    // Dark
    static let darkCollectionBgColor = UIColor.init(rgbColorCodeRed: 0, green: 0, blue: 0, alpha: 0.25)
    static let darkNotMappedCellBgColor = UIColor.init(rgbColorCodeRed: 0, green: 0, blue: 0, alpha: 0.5)
    static let darkMappedCellBgColor = UIColor.init(rgbColorCodeRed: 0, green: 0, blue: 0, alpha: 0.5)
    static let darkMappedTextColor = UIColor.white
    static let darkNotMappedTextColor = UIColor.init(rgbColorCodeRed: 66, green: 66, blue: 73, alpha: 1)
    static let darkNotMappedBorderColor = UIColor.init(rgbColorCodeRed: 66, green: 66, blue: 73, alpha: 1)
    static let darkMappedBorderColor = UIColor.white
    static let darkBackgroundImageName = "darkBackground"
 
    //Light
    static let lightCollectionBgColor = UIColor.init(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.25)
    static let lightNotMappedCellBgColor = UIColor.init(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.5)
    static let lightMappedCellBgColor = UIColor.init(rgbColorCodeRed: 255, green: 255, blue: 255, alpha: 0.5)
    static let lightMappedTextColor = UIColor.black
    static let lightNotMappedTextColor = UIColor.init(rgbColorCodeRed: 150, green: 150, blue: 150, alpha: 1)
    static let lightNotMappedBorderColor = UIColor.init(rgbColorCodeRed: 150, green: 150, blue: 150, alpha: 1)
    static let lightMappedBorderColor = UIColor.black
    static let lightBackgroundImageName = "lightBackground"
}
