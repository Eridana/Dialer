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
    func callPhoneNumber(number : String)
}

protocol MainModuleViewOutput: class {
    func moduleDidLoad()
    func didSelectItemAtIndex(index : Int)
    func moveItem(fromIndex : Int, toIndex : Int)
    func editButtonDidTap()
}


// MARK: - View Controller
final class MainModuleViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: MainModuleViewOutput!
    var dataSource = MainModuleCollectionViewDataSource()
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        dataSource.setMoveItemsCompletionHandlerAs(handler : { [unowned self] (fromIndex, toIndex) in
            self.output.moveItem(fromIndex: fromIndex, toIndex: toIndex)
            })
        output.moduleDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataSource.setScreenSize(size: self.view.frame.size)
    }
    
    // MARK : Events
    
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItemAtIndex(index: indexPath.item)
    }
}


// MARK: - View Input
extension MainModuleViewController: MainModuleViewInput {
    
    func update(withData data: [PhoneDomainModel]) {
        dataSource.update(data: data)
        collectionView.reloadData()
        
    }
    
    func update(withError error: String) {
        
    }
    
    func callPhoneNumber(number: String) {
        if let url = URL(string: "telprompt://\(number.replacingOccurrences(of: " ", with: ""))"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
