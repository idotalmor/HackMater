//
//  ProductLevel.swift
//  HackatonApp
//
//  Created by Omer Cohen on 03/03/2018.
//  Copyright © 2018 idotalmor. All rights reserved.
//

import Foundation
import UIKit

public class LevelProduct {
    
    var levelOne: String
    var levelTwo: [String]
    
    init(levelOne: String, levelTwo: [String]){
        self.levelOne = levelOne
        self.levelTwo = levelTwo
    }
}


public class LevelProductDetail {
    
    var prodSeries: String
    var prodLevel: [String]
    var prodValid: String
    var prodOpen: String
    
    var userFullName: String
    var userPhoneNum: String
    var userStreet: String
    var userCity: String
    var userHomeNum: String
    var userApartment: String
    var userFloorNum: String
    
    
    init(prodSeries: String, prodLevel: [String], prodValid: String, prodOpen: String, userFullName: String, userPhoneNum: String, userStreet: String, userCity: String, userHomeNum: String, userApartment: String, userFloorNum: String) {
        self.prodSeries = prodSeries
        self.prodLevel = prodLevel
        self.prodValid = prodValid
        self.prodOpen = prodOpen
        
        self.userFullName = userFullName
        self.userPhoneNum = userPhoneNum
        self.userStreet = userStreet
        self.userCity = userCity
        self.userHomeNum = userHomeNum
        self.userApartment = userApartment
        self.userFloorNum = userFloorNum
    }
}



