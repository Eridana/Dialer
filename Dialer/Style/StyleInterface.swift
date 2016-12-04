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

    func topViewBackgroundColor() -> UIColor
    func collectionBackgroundColor() -> UIColor
    func mappedCellBackgroundColor() -> UIColor
    func notMappedCellBackgroundColor() -> UIColor
    func mappedTextColor() -> UIColor
    func notMappedTextColor() -> UIColor
    func mappedBorderColor() -> UIColor
    func notMappedBorderColor() -> UIColor
    func tableHeaderColor() -> UIColor
    func backgroundImage() -> UIImage
    func settingsBackgroundImage() -> UIImage
    func mappedContactImage() -> UIImage
    func notMappedContactImage() -> UIImage
    func removeContactImage() -> UIImage
    func statusBarStyle() -> UIStatusBarStyle
    func barStyle() -> UIBarStyle
    func identifier() -> ThemeIdentifier
}
