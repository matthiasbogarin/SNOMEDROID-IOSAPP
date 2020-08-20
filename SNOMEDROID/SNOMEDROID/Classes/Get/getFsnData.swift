//
//  getFsnData.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/9/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import Foundation

protocol getFsnDataProtocol: class {
    func termDownloaded(term: String)
}

class getFsnData: NSObject, URLSessionDataDelegate{
    
    //properties
    
    weak var delegate: getFsnDataProtocol!
    
    var data = Data()
    
    var URLPath: String = "http://turing.manhattan.edu/~mbogarin01/SNOMEDROID/Fsn.php?id="
    
    func changeURLPath(id: String){
        URLPath = URLPath + id
    }
    
    func downloadedItems(){
        
        let url: URL = URL(string: URLPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error)
            in
            if error != nil{
                print("Failed to download data")
            }else {
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
        
    }
    
    func parseJSON(_ data:Data) {
           
           var jsonResult = NSArray()
                
           do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
               
           } catch let error as NSError {
            print("FSN & SCTID data:",error)
               
           }
           
        var jsonElement = NSDictionary()
        var locationOfTerm: String = ""
        
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
            let location = FSN()

            //the following insures none of the JsonElement values are nil through optional binding
            if let term = jsonElement["term"] as? String
            {
                location.term = term
            }
            locationOfTerm = location.term!
            }
        
        //locationOfTerm = location.term!
        //locationOfId = location.cid!
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.termDownloaded(term: locationOfTerm)
        })
    }
    
    
}

