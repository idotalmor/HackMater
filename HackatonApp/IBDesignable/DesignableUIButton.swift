//
//  DesignableUIButton.swift
//  HackatonApp
//
//  Created by ido talmor on 16/02/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//
import UIKit

@IBDesignable class DesignableButton: UIButton {
    
    @IBInspectable var circleRadius: CGFloat = 0{
        didSet{
            if(circleRadius == 2) {return}
            
            if let circle = self.imageView?.layer.frame.width{
                self.imageView?.layer.cornerRadius = (self.imageView?.layer.frame.width)! / 2
                self.imageView?.contentMode = .scaleAspectFill
                self.imageView?.clipsToBounds = true
                //self.imageView?.layer.masksToBounds = true

            }

        }}
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.imageView?.layer.cornerRadius = cornerRadius
            self.layer.cornerRadius = cornerRadius
        }}
    
    @IBInspectable var borderColor: CGFloat = 0{
        didSet{
            self.imageView?.layer.borderColor = UIColor(hexString: "#004F96").cgColor
            //self.imageView?.layer.borderColor = UIColor.white.cgColor

        }}
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.imageView?.layer.borderWidth = borderWidth
        }}
}
