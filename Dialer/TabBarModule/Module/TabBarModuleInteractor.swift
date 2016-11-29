//
//  TabBarModuleInteractor.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 29/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Interface
protocol TabBarModuleInteractorInput: class {
    
}

//MARK: Output
protocol TabBarModuleInteractorOutput: class {
    
}

// MARK: - Interactor
final class TabBarModuleInteractor: TabBarModuleInteractorInput {
    weak var output: TabBarModuleInteractorOutput!

}

