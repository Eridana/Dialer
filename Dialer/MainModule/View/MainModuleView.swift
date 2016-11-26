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
}

protocol MainModuleViewOutput: class {
    func moduleDidLoad()
    func didSelectItemAtIndex(index : Int)
    func moveItem(fromIndex : Int, toIndex : Int)
    func userSelectedContactWith(name : String, surname : String, phoneNumber : String)
}


// MARK: - View Controller
final class MainModuleViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,
                                    CNContactPickerDelegate, MainModuleCollectionViewCellDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    var editingState = EditingState.current
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
        
        localize()
        setupCollectionView()
        setupTheme()
        
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
        
        let theme = Theme.current
        
        bgImageView.image = theme.mainBackgroundImage()
        editButton.setTitleColor(theme.mappedTextColor(), for: .normal)
        editButton.setTitleColor(theme.mappedTextColor(), for: .highlighted)
        themeSegmentedControl.tintColor = theme.mappedTextColor()
        topView.backgroundColor = theme.collectionBgColor()
        collectionView.backgroundColor = theme.collectionBgColor()
        UIApplication.shared.statusBarStyle = theme.barStyle()
        
        if theme.currentTheme == .Dark {
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
        
        let editBtnTitle = editingState.isEditing ? NSLocalizedString("main_done_button_title", comment: "") :
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
        editingState.changeState()
        setEditButtonTitle()
        collectionView.reloadData()
    }
    
    func themeChanged(sender : UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            Theme.current.setCurrentTheme(theme: .Dark);
        } else {
            Theme.current.setCurrentTheme(theme: .Light);
        }
        reloadTheme()
    }
    
    // MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.didSelectItemAtIndex(index: indexPath.item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeForCell()
    }
    
    // MARK : MainModuleCollectionViewCellDelegate
    
    func actionButtonDidTapFor(phoneItem: PhoneDomainModel) {
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
        
        for labeledValue in contact.phoneNumbers {
            if labeledValue.value.stringValue != "" {
                phones.append(labeledValue.value.stringValue)
            }
        }
        
        if phones.count > 1 {
            showNumberSelectionAlert(phoneNumbers: phones, completion: { (selectedPhone) in
                if let phone = selectedPhone {
                    self.output.userSelectedContactWith(name: name, surname: surname, phoneNumber: phone)
                }
            })
        } else if (phones.count == 1) {
            self.output.userSelectedContactWith(name: name, surname: surname, phoneNumber: phones[0])
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
        
        let alertController = UIAlertController(title: NSLocalizedString("contact_no_phones_alert_title", comment: ""), message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("ok_alert_button_title", comment: ""), style: .cancel) { (_) in }
        alertController.addAction(okAction)
        
        // it seems contacts controller not dismissing for a while
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            self.present(alertController, animated: true, completion: nil)
        })
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
