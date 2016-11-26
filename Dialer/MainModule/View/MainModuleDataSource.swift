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
    var moveItemsCompletionHandler: ((Int, Int) -> Void)?
    internal var cellDelegate : MainModuleCollectionViewCellDelegate?
    
    func update(data: [PhoneDomainModel]?) {
        self.data = data
    }
    
    func registerCellFor(collectionView : UICollectionView) {
        let cellNibName = UINib(nibName: MainModuleCollectionViewCell.reuseIdentifier, bundle:nil)
        collectionView.register(cellNibName, forCellWithReuseIdentifier: MainModuleCollectionViewCell.reuseIdentifier)
    }
    
    func item(forIndexPath indexPath: IndexPath) -> PhoneDomainModel? {
        let row = indexPath.row
        guard let data = data, data.indices.contains(row) else { return nil }
        return data[row]
    }
    
    func setMoveItemsCompletionHandlerAs(handler : @escaping ((Int, Int) -> Void)) {
        self.moveItemsCompletionHandler = handler
    }
    
    func setCellDelegate(delegate : MainModuleCollectionViewCellDelegate) {
        self.cellDelegate = delegate
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
        cell.cellDelegate = cellDelegate        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let handler = moveItemsCompletionHandler {
            handler(sourceIndexPath.item, destinationIndexPath.item)
        }
    }
}
