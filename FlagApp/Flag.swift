//
//  Flag.swift
//  FlagApp
//
//  Created by ahmetburakozturk on 1.06.2023.
//

import Foundation

class Flag {
    var ID : Int?
    var FlagCountry : String?
    var FlagImage : String?
    
    init(){
        
    }
    
    init(ID: Int? = nil, FlagCountry: String? = nil, FlagImage: String? = nil) {
        self.ID = ID
        self.FlagCountry = FlagCountry
        self.FlagImage = FlagImage
    }
}
