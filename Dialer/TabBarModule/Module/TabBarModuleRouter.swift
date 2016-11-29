//
//  TabBarModuleRouter.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 29/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: Interface

protocol TabBarModuleRouterInput: class {
  
}

// MARK: - Router

final class TabBarModuleRouter: TabBarModuleRouterInput {
    weak var view: TabBarModuleViewController!
    
}
