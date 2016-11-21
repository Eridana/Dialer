//
//  MainModuleInteractor.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Interface
protocol MainModuleInteractorInput: class {
    
}

//MARK: Output
protocol MainModuleInteractorOutput: class {
    
}

// MARK: - Interactor
final class MainModuleInteractor: MainModuleInteractorInput {
    weak var output: MainModuleInteractorOutput!

}

