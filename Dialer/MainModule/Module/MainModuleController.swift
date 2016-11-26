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
            
        } else {
            interactor.possibleCallPhoneNumberFor(data: self.data![index])
        }
    }
    
    func openContacts() {
        router.openContacts()
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        
    }
    
    func userSelectedContactWith(name : String, surname : String, phoneNumber : String) {
        
    }
}
