//
//  gerParentData.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/17/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import Foundation

protocol getParentDataProtocol: class{
    func parentTermDownloaded(term: [String])
}

class getParentData: NSObject, URLSessionDataDelegate{

    weak var delegate: getParentDataProtocol!
    
    var data = Data()
    
    var termsArray : [String] = []
    
    var URLPath: String = "http://turing.manhattan.edu/~mbogarin01/SNOMEDROID/parentRel.php?id="
    
    func changeURLPath(id: String){
        URLPath = URLPath + id
        //print(URLPath)
    }
    
    func downloadedItems(){
        let url: URL = URL(string: URLPath)!
        
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error)
            in
            if error != nil{
                print("Failed to download data")
            }else {
                //print(data!)
                self.parseJSON(data!,url: url)
            }
        }
        task.resume()
        
    }
    
    func parseJSON(_ data:Data, url: URL) {
           
        var jsonResult = NSArray()
        
                
           do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as? NSArray ?? []
               
           } catch let error as NSError {
            print("parent data:")
            print(error)
               
           }
           
           var jsonElement = NSDictionary()
       
        
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
           //print("jsonelement: " , jsonElement)
            let location = Parent()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let term = jsonElement["term"] as? String
            {
                location.term = "-> " + term
            }
            
            termsArray.append(location.term!)
        }
        
        
        DispatchQueue.main.async(execute: {() -> Void in
            //print("This is the termsarray before being sent.",self.termsArray)
            self.delegate.parentTermDownloaded(term: self.termsArray)
        })
    }
    
}
