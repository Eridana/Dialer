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
        roundedView.layer.borderColor = UIColor.white.cgColor
        name.textColor = UIColor.white
        phone.textColor = UIColor.white
        name.textColor = UIColor.white
    }
    
    func configureCellAsNotMapped() {
        roundedView.layer.borderColor = UIColor.init(rgbColorCodeRed: 66, green: 66, blue: 73, alpha: 1).cgColor
        index.textColor = UIColor.init(rgbColorCodeRed: 66, green: 66, blue: 73, alpha: 1)
        name.textColor = UIColor.init(rgbColorCodeRed: 66, green: 66, blue: 73, alpha: 1)
    }
    
    override func prepareForReuse() {
        name.text = ""
        phone.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor.init(rgbColorCodeRed: 0, green: 0, blue: 0, alpha: 0.5)
        roundedView.layer.cornerRadius = 6.0
        roundedView.layer.borderWidth = 1.0
    }
}
