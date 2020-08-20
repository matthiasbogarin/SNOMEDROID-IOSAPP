//
//  getSynData.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/19/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

protocol getSynDataProtocol: class {
    func synTermDownloaded(term: [String])
    
}
class getSynData: NSObject {

    weak var delegate: getSynDataProtocol!
    
    var data = Data()
    
    var termsArray : [String] = []
    
    var URLPath: String = "http://turing.manhattan.edu/~mbogarin01/SNOMEDROID/synRel.php?id="
    
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
            print("syn data:")
               print(error)
               
           }
           
           var jsonElement = NSDictionary()
       
        
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
           //print("jsonelement: " , jsonElement)
            let location = Syn()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let term = jsonElement["term"] as? String
            {
                location.term = "(EN) : " + term
            }
            
            termsArray.append(location.term!)
        }
        
        
        DispatchQueue.main.async(execute: {() -> Void in
            //print("This is the termsarray before being sent.",self.termsArray)
            self.delegate.synTermDownloaded(term: self.termsArray)
        })
    }

    
}
