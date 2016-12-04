//
//  MainModuleCollectionViewCell.swift
//  Dialer
//
//  Created by Женя Михайлова on 21.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

protocol MainModuleCollectionViewCellDelegate : class {
    func actionButtonDidTapFor(phoneItem : PhoneDomainModel)
}

class MainModuleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var contactImageView: UIImageView!
    weak var cellDelegate : MainModuleCollectionViewCellDelegate?
    
    private var cellData : PhoneDomainModel?
    private var isEditing = false
    private var removeMappingButtonImageName = "removeCellButton"
    private var themesDataSource = ThemesDataSource()
    
    static let reuseIdentifier = "MainModuleCollectionViewCell"
    
    func fill(withData data: PhoneDomainModel) {
        /*Fill data with model*/
        cellData = data
        index.text = "\(data.index + 1)"
        name.text = data.mapped ? data.displayedName : NSLocalizedString("item_not_set_title_text", comment: "")
        phone.text = data.mapped ? data.phoneNumber : ""
        data.mapped ? configureCellAsMapped() : configureCellAsNotMapped()
        if isEditing && data.mapped {
            setupActionButton()
        }
        let theme = themesDataSource.currentTheme()
        contactImageView.image = data.mapped ? theme.mappedContactImage() : theme.notMappedContactImage()
    }
    
    func setEditing(isEditing : Bool) {
        self.isEditing = isEditing
    }
    
    func configureCellAsMapped() {
        let theme = themesDataSource.currentTheme()
        roundedView.layer.borderColor = theme.mappedBorderColor().cgColor
        roundedView.backgroundColor = theme.mappedCellBackgroundColor()
        setTextColorAs(color: theme.mappedTextColor())
    }
    
    func configureCellAsNotMapped() {
        let theme = themesDataSource.currentTheme()
        roundedView.layer.borderColor = theme.notMappedBorderColor().cgColor
        roundedView.backgroundColor = theme.notMappedCellBackgroundColor()
        setTextColorAs(color: theme.notMappedTextColor())
    }
    
    func setTextColorAs(color : UIColor) {
        name.textColor = color
        phone.textColor = color
        name.textColor = color
        index.textColor = color
    }
    
    func setupActionButton() {
        let image = themesDataSource.currentTheme().removeContactImage()
        actionButton.setImage(image, for: .normal)
        actionButton.setImage(image, for: .selected)
        actionButton.isHidden = false
    }
    
    func actionButtonDidTap(sender : UIButton) {
        if let delegate = cellDelegate {
            delegate.actionButtonDidTapFor(phoneItem: cellData!)
        }
    }
    
    override func prepareForReuse() {
        name.text = ""
        phone.text = ""
        actionButton.isHidden = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedView.layer.cornerRadius = 6.0
        roundedView.layer.borderWidth = 1.0
        actionButton.addTarget(self, action: #selector(actionButtonDidTap(sender:)), for: .touchUpInside)
    }
}
