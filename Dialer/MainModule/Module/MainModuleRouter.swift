//
//  MainModuleRouter.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit
import ContactsUI

// MARK: Interface

protocol MainModuleRouterInput: class {
    func openContacts()
}

// MARK: - Router

final class MainModuleRouter: MainModuleRouterInput {
    weak var view: MainModuleViewController!

    func openContacts() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.displayedPropertyKeys = [CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey];
        contactPicker.delegate = view
        contactPicker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        view.present(contactPicker, animated: true, completion: nil)
    }
    
}
