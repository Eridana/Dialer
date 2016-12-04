//
//  TabBarModuleView.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 29/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: - Interface
protocol TabBarModuleViewInput: class {
    func setViews(views : [UIViewController])
    func update(withError error: String)
}

protocol TabBarModuleViewOutput: class {
    func moduleDidLoad()
}


// MARK: - View Controller
final class TabBarModuleViewController: UITabBarController {
    
    var output: TabBarModuleViewOutput!
    //var themesDataSource = ThemesDataSource()
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //output.moduleDidLoad()
    }
    
    func setupTabs() {
        let mainTabItem = tabBar.items?[0];
        mainTabItem?.title = NSLocalizedString("fast_call_tab_item_title", comment: "")
        mainTabItem?.image = UIImage.init(named: "phoneIcon")
        
        let settingsTabItem = tabBar.items?[1];
        settingsTabItem?.title = NSLocalizedString("settings_tab_item_title", comment: "")
        settingsTabItem?.image = UIImage.init(named: "settingsIcon")
    }
    
    func setupUI() {
        setupTabs()
        tabBar.barStyle = UIBarStyle.black
        tabBar.isTranslucent = true
        tabBar.tintColor = UIColor.white
    }    
}


// MARK: - View Input 
extension TabBarModuleViewController: TabBarModuleViewInput {
    
    func setViews(views : [UIViewController]) {
        self.viewControllers = views
        setupUI()
    }
    
    func update(withError error: String) {
        
    }
}
