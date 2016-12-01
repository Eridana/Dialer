//
//  SettingsModuleInteractor.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Interface
protocol SettingsModuleInteractorInput: class {
    
}

//MARK: Output
protocol SettingsModuleInteractorOutput: class {
    
}

// MARK: - Interactor
final class SettingsModuleInteractor: SettingsModuleInteractorInput {
    weak var output: SettingsModuleInteractorOutput!

}

