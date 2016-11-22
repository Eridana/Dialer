//
//  PhoneDomainModel.swift
//  Dialer
//
//  Created by Женя Михайлова on 21.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class PhoneDomainModel: NSObject {
    
    var index : Int?
    var phoneNumber : String?
    var displayedName : String?
    var mapped : Bool?
    
    init(index : Int?, phoneNumber : String?, displayedName : String?, mapped: Bool?) {
        self.index = index
        self.phoneNumber = phoneNumber
        self.displayedName = displayedName
        self.mapped = mapped
    }
}
