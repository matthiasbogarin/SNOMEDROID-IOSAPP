//
//  getParentData.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/5/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

class getParentData: NSObject {

    var dbParentData : [NSDictionary]?
    var myURL : String?
    
    enum JSONError : String, Error{
        case NoData = "Error: No Data"
        case ConversionFailed = "Error: converson from JSON Failed"
    }
    
    func setUpUrl(selected_id: String ){
        myURL = "turing.manhattan.edu/~mbogarin01/SNOMEDROID/parent.php?id=" + selected_id as String

        jsonParser()
    }
    
    func jsonParser(){
        
        guard let endpoint = URL(string: myURL!) else {
            print("Error creating connection")
            return
        }
        
        let request = URLRequest(url: endpoint)
        
        URLSession.shared.dataTask(with: request){
            (data,response, error) in
            
            do{
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print(dataString!)
                
                guard let data = data
                else{
                    throw JSONError.NoData
                }
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [NSDictionary]
                    else{
                    throw JSONError.ConversionFailed
                }
                print(json)
                self.dbParentData = json
            }catch let error as JSONError{
                print(error.rawValue)
            }catch let error as NSError{
                print(error.debugDescription)
            }
    
        }.resume()
    }

}

