//
//  StyleInterface.swift
//  Dialer
//
//  Created by Женя Михайлова on 28.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

enum ThemeIdentifier : String {
    case dark
    case light
}

protocol StyleInterface: class {

    func collectionBackgroundColor() -> UIColor
    func mappedCellBackgroundColor() -> UIColor
    func notMappedCellBackgroundColor() -> UIColor
    func mappedTextColor() -> UIColor
    func notMappedTextColor() -> UIColor
    func mappedBorderColor() -> UIColor
    func notMappedBorderColor() -> UIColor
    func backgroundImage() -> UIImage
    func statusBarStyle() -> UIStatusBarStyle
    func identifier() -> ThemeIdentifier
}
