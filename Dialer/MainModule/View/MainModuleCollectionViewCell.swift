//
//  MainModuleCollectionViewCell.swift
//  Dialer
//
//  Created by Женя Михайлова on 21.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class MainModuleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var index: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    static let reuseIdentifier = "MainModuleCollectionViewCell"
    
    func fill(withData data: PhoneDomainModel) {
        /*Fill data with model*/
        index.text = "\(data.index + 1)"
        name.text = data.mapped ? data.displayedName : NSLocalizedString("item_not_set_title_text", comment: "")
        phone.text = data.mapped ? data.phoneNumber : ""
        data.mapped ? configureCellAsMapped() : configureCellAsNotMapped()
    }
    
    func configureCellAsMapped() {
        roundedView.layer.borderColor = Theme().mappedBorderColor().cgColor
        name.textColor = Theme().mappedTextColor()
        phone.textColor = Theme().mappedTextColor()
        name.textColor = Theme().mappedTextColor()
    }
    
    func configureCellAsNotMapped() {
        roundedView.layer.borderColor = Theme().notMappedBorderColor().cgColor
        index.textColor = Theme().notMappedTextColor()
        name.textColor = Theme().notMappedTextColor()
    }
    
    override func prepareForReuse() {
        name.text = ""
        phone.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = Theme().cellBgColor()
        roundedView.layer.cornerRadius = 6.0
        roundedView.layer.borderWidth = 1.0
    }
}
