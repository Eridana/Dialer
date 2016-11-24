//
//  MainModuleAssembly.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//
import UIKit

final class MainModuleAssembly
{
	class func createModule(configure: (_ module: MainModuleModuleInput) -> Void) -> UIViewController {
	
		let view = MainModuleViewController(nibName: "MainModuleViewController", bundle: nil)
	
        view.configure()

		let interactor = MainModuleInteractor()
		let controller = MainModuleController()
		let router = MainModuleRouter()

        let dataSource = PhoneNumbersDataSource()
        let themesDataSource = ThemesDataSource()
		interactor.output = controller
        interactor.dataSource = dataSource
        interactor.themesDataSource = themesDataSource

		controller.view = view
		controller.interactor = interactor
		controller.router = router

		configure(controller)

		view.output = controller

		router.view = view

		return view
	}
}

