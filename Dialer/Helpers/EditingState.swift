//
//  EditingState.swift
//  Dialer
//
//  Created by Женя Михайлова on 26.11.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

class EditingState: NSObject {

    static let current = EditingState()
    
    private(set) public var isEditing = false
    
    override init() {
        super.init()
    }
    
    func changeState() {
        isEditing = !isEditing
    }
}
