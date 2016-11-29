//
//  TabBarModuleController.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 29/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//


// MARK: - Controller
final class TabBarModuleController: TabBarModuleModuleInput {

    var interactor: TabBarModuleInteractorInput!
    var router: TabBarModuleRouterInput!
    weak var view: TabBarModuleViewInput!
    weak var output: TabBarModuleModuleOutput?

    // MARK: - Module Input
    func setupDelegate(output: TabBarModuleModuleOutput) {
        self.output = output
    }
}

// MARK: - Interactor Output
extension TabBarModuleController: TabBarModuleInteractorOutput {
    
}

// MARK: - View Output
extension TabBarModuleController: TabBarModuleViewOutput {
    
    func moduleDidLoad() {
        //
    }
}
