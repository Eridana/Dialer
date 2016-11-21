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
    var size : CGSize?
    let widthItemsCount = 3
    let heightItemsCount = 4
    var moveItemsCompletionHandler: ((Int, Int) -> Void)?
    
    func update(data: [PhoneDomainModel]?) {
        self.data = data
    }
    
    func item(forIndexPath indexPath: IndexPath) -> PhoneDomainModel? {
        let row = indexPath.row
        guard let data = data, data.indices.contains(row) else { return nil }
        return data[row]
    }
    
    func setScreenSize(size : CGSize) {
        self.size = size
    }
    
    func sizeForCell() -> CGSize {
        guard let size = self.size else { return CGSize(width: 0.0, height: 0.0) }
        let kWidth = size.width / CGFloat(self.widthItemsCount) - CGFloat(self.widthItemsCount - 1)
        let kHeight = size.height / CGFloat(self.heightItemsCount) - CGFloat(self.heightItemsCount - 1)
        return CGSize(width: CGFloat(kWidth), height: CGFloat(kHeight))
    }
    
    func setMoveItemsCompletionHandlerAs(handler : @escaping ((Int, Int) -> Void)) {
        self.moveItemsCompletionHandler = handler
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return self.sizeForCell()
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
