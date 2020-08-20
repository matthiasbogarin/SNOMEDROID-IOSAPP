//
//  groupClass.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/19/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import Foundation

class Attribute: NSObject {

    //properties
    var type: String?
    var destination: String?
     
     
     //empty constructor
     override init(){
         
     }
     
     //construct with cid, fsn, id and term parameters
     
    init(type: String,destination: String){
        self.type = type
        self.destination = destination
     }
    
     //print objects current state
     override var description: String {
         return "Term: \(type!), Destination: \(destination!)"
     }
}
