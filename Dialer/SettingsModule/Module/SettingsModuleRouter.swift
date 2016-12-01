//
//  SettingsModuleRouter.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: Interface

protocol SettingsModuleRouterInput: class {
  
}

// MARK: - Router

final class SettingsModuleRouter: SettingsModuleRouterInput {
    weak var view: SettingsModuleViewController!
    
}
