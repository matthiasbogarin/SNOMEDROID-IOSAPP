//
//  synClass.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/19/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import Foundation

class Syn: NSObject {
   
    //properties
      var term: String?
      
      
      //empty constructor
      override init(){
          
      }
      
      //construct with cid, fsn, id and term parameters
      
      init(term: String){
          
          self.term = term
      }
     
      //print objects current state
      override var description: String {
          return "Term: \(term!)"
      }
    
}
