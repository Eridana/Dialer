//
//  MainModuleView.swift
//  Dialer
//
//  Created by Evgeniya Mikhailova on 21/11/2016.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

// MARK: - Interface
protocol MainModuleViewInput: class {
    func update(withData data: [PhoneDomainModel])
    func update(withError error: String)
    func callPhoneNumber(number : String)
    func showChangeMappingAlert()
}

protocol MainModuleViewOutput: class {
    func moduleDidLoad()
    func didSelectEditItemAtIndex(index : Int)
    func didSelectCallItemAtIndex(index : Int)
    func moveItem(fromIndex : Int, toIndex : Int)
    func removeItemDidTap(phoneItem : PhoneDomainModel)
    func userSelectedContactWith(name : String, surname : String, phoneNumber : String, atIndex : Int)
    func userDidSelectContactChange()
}


// MARK: - View Controller
final class MainModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                    CNContactPickerDelegate, MainModuleCollectionViewCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    var output: MainModuleViewOutput!
    var dataSource = MainModuleCollectionViewDataSource()
    var themesDataSource = ThemesDataSource()
    let widthItemsCount = 3
    let heightItemsCount = 4
    var selectedItemIndex = 0
    
    // MARK: - Life cycle
    func configure() {
        /* basic view configuration */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        localize()
        setupCollectionView()
        setupTheme()
        
        editButton .addTarget(self, action: #selector(editTapped), for: .touchUpInside)
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged(sender:)), for: .valueChanged)
        
        dataSource.setMoveItemsCompletionHandlerAs(handler : { [unowned self] (fromIndex, toIndex) in
            self.output.moveItem(fromIndex: fromIndex, toIndex: toIndex)
        })
        dataSource.registerCellFor(collectionView: collectionView)
        dataSource.setCellDelegate(delegate: self)
        
        output.moduleDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func setupTheme() {
        
        let theme = themesDataSource.currentTheme()
        
        bgImageView.image = theme.backgroundImage()
        editButton.setTitleColor(theme.mappedTextColor(), for: .normal)
        editButton.setTitleColor(theme.mappedTextColor(), for: .highlighted)
        themeSegmentedControl.tintColor = theme.mappedTextColor()
        topView.backgroundColor = theme.collectionBackgroundColor()
        collectionView.backgroundColor = theme.collectionBackgroundColor()
        UIApplication.shared.statusBarStyle = theme.statusBarStyle()
    }
    
    func setupSegmentedControl() {
        
        if themesDataSource.currentTheme().identifier() == .dark {
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
        
        let editBtnTitle = isEditing ? NSLocalizedString("main_done_button_title", comment: "") :
                                       NSLocalizedString("main_edit_button_title", comment: "")
        // to prevent title flashing set title, then resize
        editButton.titleLabel?.text = editBtnTitle;
        editButton.setTitle(editBtnTitle, for: .normal)
        editButton.setTitle(editBtnTitle, for: .highlighted)
    }
    
    // Mark themes reload 
    
    func reloadTheme() {
        setupTheme()
        collectionView.reloadData()
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
        isEditing = !isEditing
        dataSource.setEditing(isEditing : isEditing)
        setEditButtonTitle()
        collectionView.reloadData()
    }
    
    func themeChanged(sender : UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            themesDataSource.setCurrentThemeBy(identifier: .dark)
        } else {
            themesDataSource.setCurrentThemeBy(identifier: .light)
        }
        reloadTheme()
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.item
        if isEditing {
            output.didSelectEditItemAtIndex(index: selectedItemIndex)
        } else {
            output.didSelectCallItemAtIndex(index: selectedItemIndex)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForCell()
    }
    
    // MARK : MainModuleCollectionViewCellDelegate
    
    func actionButtonDidTapFor(phoneItem: PhoneDomainModel) {
        // remove this mapping
        output.removeItemDidTap(phoneItem : phoneItem)
    }
    
     // MARK : CNContactPickerDelegate
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: false, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        guard contact.phoneNumbers.count > 0 else {
            showNoPhonesAlert()
            return
        }
        
        let name = contact.givenName
        let surname = contact.familyName
        var phones = Array<String>()
        
        let selectedIndex = selectedItemIndex
        
        for labeledValue in contact.phoneNumbers {
            if labeledValue.value.stringValue != "" {
                phones.append(labeledValue.value.stringValue)
            }
        }
        
        if phones.count > 1 {
            showNumberSelectionAlert(phoneNumbers: phones, completion: { (selectedPhone) in
                if let phone = selectedPhone {
                    self.output.userSelectedContactWith(name: name, surname: surname, phoneNumber: phone, atIndex: selectedIndex)
                }
            })
        } else if (phones.count == 1) {
            self.output.userSelectedContactWith(name: name, surname: surname, phoneNumber: phones[0], atIndex: selectedIndex)
        }
    }
    
    // MARK : Select phone number to binding
    
    func showNumberSelectionAlert(phoneNumbers : [String], completion : @escaping (_ selectedNumber : String?) -> ()) {
        
        let alertController = UIAlertController(title: nil, message: NSLocalizedString("contact_phone_selection_alert_title", comment: ""), preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("cancel_alert_button_title", comment: ""), style: .cancel) { (action) in
            completion(nil)
        }
        alertController.addAction(cancelAction)
        
        for phone in phoneNumbers {
            alertController.addAction(UIAlertAction(title: phone, style : .default) { (action) in
                completion(phone)
            })
        }

        // it seems contacts controller not dismissing for a while
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.present(alertController, animated: true, completion: nil)
        })
    }
    
    func showNoPhonesAlert() {

        let alert = alertControllerWith(title: NSLocalizedString("contact_no_phones_alert_title", comment: ""), cancelButtonTitle: NSLocalizedString("ok_alert_button_title", comment: ""))
        
        // it seems contacts controller not dismissing for a while
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func alertControllerWith(title : String? = nil, message : String? = nil, okButtonTitle : String?  = nil, cancelButtonTitle : String,
                       okCompletion :@escaping () -> () = {}) -> UIAlertController {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in }
        
        alertController.addAction(cancelAction)
        
        if let okTitle = okButtonTitle {
            
            let okAction = UIAlertAction(title: okTitle, style: .default) { (action) in
                okCompletion()
            }
            alertController.addAction(okAction)
        }
        
        return alertController
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
    
    func showChangeMappingAlert() {
        
        let title = NSLocalizedString("change_mapping_alert_button_title", comment: "")
        let okButtonTitle = NSLocalizedString("yes_alert_button_title", comment: "")
        let cancelButtonTitle = NSLocalizedString("no_alert_button_title", comment: "")
        
        let alert = alertControllerWith(title: title, okButtonTitle: okButtonTitle, cancelButtonTitle: cancelButtonTitle, okCompletion: {
            self.output.userDidSelectContactChange()
        })
        
        // it seems contacts controller not dismissing for a while
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.present(alert, animated: true, completion: nil)
        })
        
    }
}
