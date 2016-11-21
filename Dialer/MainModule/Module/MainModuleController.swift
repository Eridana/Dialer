//
//  MainModuleController.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Controller
final class MainModuleController: MainModuleModuleInput {

    var interactor: MainModuleInteractorInput!
    var router: MainModuleRouterInput!
    weak var view: MainModuleViewInput!
    weak var output: MainModuleModuleOutput?

    // MARK: - Module Input
    func setupDelegate(output: MainModuleModuleOutput) {
        self.output = output
    }
}

// MARK: - Interactor Output
extension MainModuleController: MainModuleInteractorOutput {
    
}

// MARK: - View Output
extension MainModuleController: MainModuleViewOutput {
    
    func moduleDidLoad() {
        //
    }
    
    func didSelectItemAtIndex(index : Int) {
        
    }
    
    func moveItem(fromIndex: Int, toIndex: Int) {
        
    }
    
    func editButtonDidTap() {
        
    }
}
