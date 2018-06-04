//
//  UIImage+Extensions.swift
//  Dialer
//
//  Created by Женя Михайлова on 03.12.16.
//  Copyright © 2016 Evgeniya Mikhailova. All rights reserved.
//

import UIKit

extension UIImage {

    func imageWithTintColor(_ tintColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect = CGRect(x:0, y:0, width:self.size.width, height:self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return returnedImage
    }

    func imageWithAlpha(_ alpha: Float) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0);
        if let context = UIGraphicsGetCurrentContext() {
            let rect = CGRect(x:0, y:0, width:self.size.width, height:self.size.height)
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -rect.size.height)
            context.setBlendMode(CGBlendMode.multiply)
            context.setAlpha(CGFloat(alpha))
            context.draw(self.cgImage!, in: rect)
        }
        let returnedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return returnedImage
    }
}
