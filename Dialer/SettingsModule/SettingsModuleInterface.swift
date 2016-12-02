//
//  SettingsModuleInterface.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

// MARK: - Module interface
// MARK: Input

protocol SettingsModuleModuleInput: class { 
    func setupDelegate(output: SettingsModuleModuleOutput)
}


// MARK: Output

protocol SettingsModuleModuleOutput: class {
    
}

