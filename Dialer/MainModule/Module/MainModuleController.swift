//
//  MainModuleController.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import Result

// MARK: - Controller
final class MainModuleController: MainModuleModuleInput {

    var interactor: MainModuleInteractorInput!
    var router: MainModuleRouterInput!
    weak var view: MainModuleViewInput!
    weak var output: MainModuleModuleOutput?
    var data : [PhoneDomainModel]?

    // MARK: - Module Input
    func setupDelegate(output: MainModuleModuleOutput) {
        self.output = output
    }
}

// MARK: - Interactor Output
extension MainModuleController: MainModuleInteractorOutput {
    
    func callPhoneNumber(number : String) {
        self.view.callPhoneNumber(number : number)
    }
}

// MARK: - View Output
extension MainModuleController: MainModuleViewOutput {
    
    func moduleDidLoad() {
        interactor.requestData { [unowned self] (result) in
            switch result {
                case .success(let data) :
                    self.data = data
                    self.view.update(withData:data)
                case .failure(let error):
                    self.view.update(withError:error.description)
            }
        }
    }
    
    func didSelectItemAtIndex(index : Int) {
        if EditingState.current.isEditing {
            if interactor.shouldPresentContactsScreenFor(phoneItem: data![index]) {
                openContacts()
            } else {
                view.showChangeMappingAlert()
            }
        } else {
            interactor.possibleCallPhoneNumberFor(data: self.data![index])
        }
    }
    
    func openContacts() {
        router.openContacts()
    }
    
    func removeItemDidTap(phoneItem : PhoneDomainModel) {
        interactor.removeItemMapping(phoneItem : phoneItem)
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        
    }
    
    func userSelectedContactWith(name : String, surname : String, phoneNumber : String, atIndex : Int) {
        interactor.updateContactWith(name: name, surname: surname, phoneNumber: phoneNumber, atIndex: atIndex)
    }
    
    func userDidSelectContactChange() {
        router.openContacts()
    }
    
    func updateWith(data : [PhoneDomainModel]) {
        self.view.update(withData:data)
    }
}
