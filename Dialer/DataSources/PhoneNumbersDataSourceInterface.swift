//
//  PhoneNumbersDataSourceInterface.swift
//  Dialer
//
//  Created by Женя Михайлова on 23.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

protocol PhoneNumbersDataSourceInterface: class {
    func save(array:[PhoneDomainModel]) -> Bool;
    func load(_ result: @escaping (Result<[PhoneDomainModel], NSError>) -> ());
    func createObjects(count : Int) -> [PhoneDomainModel]?
}
