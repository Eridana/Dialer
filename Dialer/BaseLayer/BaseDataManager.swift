//
//  BaseDataManager.swift
//  Dialer
//
//  Created by Женя Михайлова on 19.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

protocol BaseDataManager: class {
    func save(array:[BaseObject]) -> Bool
    //func load(_ result: @escaping (Result<[PhoneObject], NSError>) -> ())
}
