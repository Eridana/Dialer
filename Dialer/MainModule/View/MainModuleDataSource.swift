//
//  MainModuleDataSource.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

final class MainModuleCollectionViewDataSource: NSObject {
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

extension MainModuleCollectionViewDataSource: UICollectionViewDataSource {
    
    // MARK: Sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: Items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item(forIndexPath: indexPath),
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainModuleCollectionViewCell.reuseIdentifier, for: indexPath) as? MainModuleCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.fill(withData: item)
        return cell
    }
}
