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
final class MainModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var output: MainModuleViewOutput!
    var dataSource = MainModuleCollectionViewDataSource()
    let widthItemsCount = 3
    let heightItemsCount = 4
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.init(rgbColorCodeRed: 0, green: 0, blue: 0, alpha: 0.25)
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        dataSource.setMoveItemsCompletionHandlerAs(handler : { [unowned self] (fromIndex, toIndex) in
            self.output.moveItem(fromIndex: fromIndex, toIndex: toIndex)
            })
        dataSource.registerCellFor(collectionView: collectionView)
        output.moduleDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupNavigationItem() {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
        barButtonItem.tintColor = UIColor.white
        self.navigationItem.setRightBarButtonItems([barButtonItem], animated: false)
    }
    
    // MARK : Size for cell
    
    func sizeForCell() -> CGSize {
        let size = self.view.frame.size
        let spacing = 4;
        let kWidth = size.width / CGFloat(self.widthItemsCount) - CGFloat((self.widthItemsCount - 1) * spacing)
        let kHeight = size.height / CGFloat(self.heightItemsCount) - CGFloat((self.heightItemsCount - 1) * (spacing * 2))
        return CGSize(width: CGFloat(kWidth), height: CGFloat(kHeight))
    }
    
    // MARK : Events
    
    func editTapped() {
        print("editTapped")
        
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItemAtIndex(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForCell()
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
