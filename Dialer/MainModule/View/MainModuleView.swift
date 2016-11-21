//
//  MainModuleView.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit


// MARK: - Interface
protocol MainModuleViewInput: class {
    func update(withData data: [PhoneDomainModel])
    func update(withError error: String)
}

protocol MainModuleViewOutput: class {
    func moduleDidLoad()
}


// MARK: - View Controller
final class MainModuleViewController: UITableViewController {
    
    var output: MainModuleViewOutput!
    var dataSource = MainModuleTableDataSource()    
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        output.moduleDidLoad()
    }
}


// MARK: - View Input 
extension MainModuleViewController: MainModuleViewInput {
    
    func update(withData data: [PhoneDomainModel]) { 
        dataSource.update(data: data)
        tableView.reloadData()
        
    }
    
    func update(withError error: String) {
        
    }
}
