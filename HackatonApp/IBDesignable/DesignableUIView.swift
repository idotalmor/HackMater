//
//  DesignableUIView.swift
//  HackatonApp
//
//  Created by ido talmor on 15/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import UIKit

@IBDesignable class DesignableUIView: UIView {
    
    @IBInspectable var circleRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = self.frame.size.width / 2
            self.clipsToBounds = true
            
        }}
    
    @IBInspectable var Radius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = Radius
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


