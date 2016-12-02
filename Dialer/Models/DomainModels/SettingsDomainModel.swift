//
//  SettingsDomainModel.swift
//  Dialer
//
//  Created by Женя Михайлова on 01.12.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

enum NameDisplayType {
    case firstThenLast
    case lastThenFirst
    case firstNameOnly
}

struct SettingsDomainModel {
    var nameDisplayType : NameDisplayType?
}
