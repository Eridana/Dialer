//
//  SettingsModuleController.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Controller
final class SettingsModuleController: SettingsModuleModuleInput {

    var interactor: SettingsModuleInteractorInput!
    var router: SettingsModuleRouterInput!
    weak var view: SettingsModuleViewInput!
    weak var output: SettingsModuleModuleOutput?
    
    // MARK: - Module Input
    func setupDelegate(output: SettingsModuleModuleOutput) {
        self.output = output
    }
}

// MARK: - Interactor Output
extension SettingsModuleController: SettingsModuleInteractorOutput {
    
}

// MARK: - View Output
extension SettingsModuleController: SettingsModuleViewOutput {
    
    func moduleDidLoad() {
        
    }
    
    func setNameDisplayStyle(_ style: NameDisplayStyle) {
        interactor.setNameDisplayStyle(style : style)
    }
}
