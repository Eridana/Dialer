//
//  MainModuleRouter.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: Interface

protocol MainModuleRouterInput: class {
  
}

// MARK: - Router

final class MainModuleRouter: MainModuleRouterInput {
    weak var view: MainModuleViewController!
    
}
