//
//  DesignableImageView.swift
//  HackatonApp
//
//  Created by ido talmor on 16/02/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

@IBDesignable class DesignableImageView: UIImageView {
    
    @IBInspectable var circleRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true

        }}
    
    @IBInspectable var borderColor: CGFloat = 0{
        didSet{
            self.layer.borderColor = UIColor(hexString: "#007AFF").cgColor
            //self.imageView?.layer.borderColor = UIColor.white.cgColor
            
        }}
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }}
}

