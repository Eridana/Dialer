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
    @IBOutlet weak var addImageView: UIImageView!
    weak var cellDelegate : MainModuleCollectionViewCellDelegate?
    
    private var cellData : PhoneDomainModel?
    private var removeMappingButtonImageName = "removeCellButton"
    
    static let reuseIdentifier = "MainModuleCollectionViewCell"
    
    func fill(withData data: PhoneDomainModel) {
        /*Fill data with model*/
        cellData = data
        index.text = "\(data.index + 1)"
        name.text = data.mapped ? data.displayedName : NSLocalizedString("item_not_set_title_text", comment: "")
        phone.text = data.mapped ? data.phoneNumber : ""
        data.mapped ? configureCellAsMapped() : configureCellAsNotMapped()
        roundedView.backgroundColor = Theme.current.cellBgColor()
        
        let mapped = data.mapped
        let isEditing = EditingState.current.isEditing
        

        if isEditing {
            if mapped {
                setupActionButton()
                name.isHidden = false
            } else {
                name.isHidden = true
                addImageView.isHidden = false
            }
        } else {
            name.isHidden = false
            addImageView.isHidden = true
        }
    }
    
    func configureCellAsMapped() {
        roundedView.layer.borderColor = Theme.current.mappedBorderColor().cgColor
        name.textColor = Theme.current.mappedTextColor()
        phone.textColor = Theme.current.mappedTextColor()
        name.textColor = Theme.current.mappedTextColor()
    }
    
    func configureCellAsNotMapped() {
        roundedView.layer.borderColor = Theme.current.notMappedBorderColor().cgColor
        index.textColor = Theme.current.notMappedTextColor()
        name.textColor = Theme.current.notMappedTextColor()
    }
    
    func setupActionButton() {
        let image = UIImage(named: removeMappingButtonImageName)
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
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        roundedView.layer.cornerRadius = 6.0
        roundedView.layer.borderWidth = 1.0
        actionButton.addTarget(self, action: #selector(actionButtonDidTap(sender:)), for: .touchUpInside)
    }
}
