//
//  SettingsModuleAssembly.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 01/12/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//
import UIKit

final class SettingsModuleAssembly
{
	class func createModule(configure: (_ module: SettingsModuleModuleInput) -> Void) -> UIViewController {
			
        let storyboard = UIStoryboard.init(name: "Settings", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "SettingsModuleViewController") as! SettingsModuleViewController
	
        view.configure()

		let interactor = SettingsModuleInteractor()
		let controller = SettingsModuleController()
		let router = SettingsModuleRouter()
        
        let settingsDataSource = SettingsDataSourceUserDefaultsBased(withDefaultsKey: "settings")

		interactor.output = controller
        interactor.settingsDataSource = settingsDataSource
        
		controller.view = view
		controller.interactor = interactor
		controller.router = router

		configure(controller)

		view.output = controller

		router.view = view

//        let navigationController = UINavigationController.init(rootViewController: view)
//        navigationController.navigationBar.barStyle = .default
        
		return view
	}
}

