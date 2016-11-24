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
    func reloadTheme()
    func callPhoneNumber(number : String)
    func editButtonDidTap()
}

protocol MainModuleViewOutput: class {
    func moduleDidLoad()
    func didSelectItemAtIndex(index : Int)
    func moveItem(fromIndex : Int, toIndex : Int)
    func editButtonTapped()
    func themeSelectedWith(index : Int)
}


// MARK: - View Controller
final class MainModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    var isEditingState = false
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
        
        self.localize()
        self.setupCollectionView()
        
        editButton .addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged(sender:)), for: .valueChanged)
        
        dataSource.setMoveItemsCompletionHandlerAs(handler : { [unowned self] (fromIndex, toIndex) in
            self.output.moveItem(fromIndex: fromIndex, toIndex: toIndex)
        })
        dataSource.registerCellFor(collectionView: collectionView)
        
        output.moduleDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupTheme() {
        bgImageView.image = Theme.current.mainBackgroundImage()
        editButton.titleLabel?.textColor = Theme.current.mappedTextColor()
        themeSegmentedControl.tintColor = Theme.current.mappedTextColor()
        topView.backgroundColor = Theme.current.collectionBgColor()
        collectionView.backgroundColor = Theme.current.collectionBgColor()
        UIApplication.shared.statusBarStyle = Theme.current.barStyle()
        
        if Theme.current.currentTheme == .Dark {
            self.themeSegmentedControl.selectedSegmentIndex = 0
        } else {
            self.themeSegmentedControl.selectedSegmentIndex = 1
        }
    }
    
    func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
    }
    
    func localize() {
        themeSegmentedControl.setTitle(NSLocalizedString("main_segment_dark_title", comment: ""), forSegmentAt: 0)
        themeSegmentedControl.setTitle(NSLocalizedString("main_segment_Light_title", comment: ""), forSegmentAt: 1)
        setEditButtonTitle()
    }
    
    func setEditButtonTitle() {
        let editBtnTitle = isEditingState ? NSLocalizedString("main_done_button_title", comment: "") :
                                            NSLocalizedString("main_edit_button_title", comment: "")
        editButton.setTitle(editBtnTitle, for: .normal)
    }
    
    // MARK : Size for cell
    
    func sizeForCell() -> CGSize {
        let size = view.frame.size
        let spacing = 4;
        let kWidth = size.width / CGFloat(widthItemsCount) - CGFloat((widthItemsCount - 1) * spacing)
        let kHeight = size.height / CGFloat(heightItemsCount) - CGFloat((heightItemsCount - 1) * (spacing * 2))
        return CGSize(width: CGFloat(kWidth), height: CGFloat(kHeight))
    }
    
    // MARK : Events
    
    func editTapped() {
        output.editButtonTapped()
    }
    
    func themeChanged(sender : UISegmentedControl) {
        output.themeSelectedWith(index: sender.selectedSegmentIndex)
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
    
    func reloadTheme() {
        setupTheme()
        collectionView.reloadData()
    }
    
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
    
    func editButtonDidTap() {
        isEditingState = !isEditingState
        setEditButtonTitle()
        collectionView.reloadData()
    }
}
