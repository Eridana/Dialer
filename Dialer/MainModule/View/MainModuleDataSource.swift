//
//  MainModuleDataSource.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

final class MainModuleTableDataSource: NSObject {
    var data: [PhoneDomainModel]?
    
    func update(data: [PhoneDomainModel]?) {
        self.data = data
    }
    
    func item(forIndexPath indexPath: IndexPath) -> PhoneDomainModel? {
        let row = indexPath.row
        guard let data = data, data.indices.contains(row) else { return nil }
        return data[row]
    }
}

extension MainModuleTableDataSource: UITableViewDataSource {
    
    // MARK: Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = item(forIndexPath: indexPath),
            let cell = tableView.dequeueReusableCell(withIdentifier: MainModuleTableViewCell.reuseIdentifier) as? MainModuleTableViewCell
        else { return UITableViewCell() }
        
        cell.fill(withData: item)
        return cell
    }
}