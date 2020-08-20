//
//  termsClass.swift
//  SNOMEDROID
//
//  Created by Leon Wu on 3/21/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//


//Terms structure to be used to decode JSON terms
import UIKit

struct Terms: Decodable
{
    let conceptId : Int
    let term: String
    
}
