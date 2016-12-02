//
//  TabBarModuleAssembly.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 29/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//
import UIKit


final class TabBarModuleAssembly
{
	class func createModule(configure: (_ module: TabBarModuleModuleInput) -> Void) -> UITabBarController {
			
		let view = TabBarModuleViewController()

		let interactor = TabBarModuleInteractor()
		let controller = TabBarModuleController()
		let router = TabBarModuleRouter()

		interactor.output = controller

		controller.view = view
		controller.interactor = interactor
		controller.router = router

		configure(controller)

		view.output = controller
        
        let mainViewController = MainModuleAssembly.createModule { _ in }
        let settingsViewController = SettingsModuleAssembly.createModule { _ in }
        
        view.setViews(views: [mainViewController, settingsViewController])

		router.view = view

		return view
	}
  
}

