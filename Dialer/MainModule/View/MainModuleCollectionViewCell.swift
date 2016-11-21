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
    
    static let reuseIdentifier = "MainModuleCollectionViewCell"
    
    func fill(withData data: PhoneDomainModel) {
        /*Fill data with model*/
        guard data.mapped != nil else {
            name.text = NSLocalizedString("item_not_set_title_text", comment: "item did not set")
            return
        }
        name.text = data.displayedName
        phone.text = data.phoneNumber
    }
    
    override func prepareForReuse() {
        name.text = ""
        phone.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
