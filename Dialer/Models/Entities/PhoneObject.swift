//
//  PhonePlainObject.swift
//  Dialer
//
//  Created by Женя Михайлова on 19.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit
import Contacts

class PhoneEntity: BaseObject, NSCoding {
    
    var index : Int?
    var phoneNumber : String?
    var displayedName : String?
    var mapped : Bool?
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.index = aDecoder.decodeInteger(forKey: "index")
        self.phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String
        self.displayedName = aDecoder.decodeObject(forKey: "displayedName") as? String
        self.mapped = aDecoder.decodeBool(forKey: "mapped")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.index, forKey: "index")
        aCoder.encode(self.phoneNumber, forKey: "phoneNumber")
        aCoder.encode(self.displayedName, forKey: "displayedName")
        aCoder.encode(self.mapped, forKey: "mapped")
    }
}
