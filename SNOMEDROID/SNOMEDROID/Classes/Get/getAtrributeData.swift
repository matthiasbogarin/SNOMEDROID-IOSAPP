//
//  getGroupData.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/19/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

protocol getAttributeDataProtocol: class {
    func typeTermDownloaded(type: [String])
    func destinationDownloaded(destination: [String])
}
class getAttributeData: NSObject {

    weak var delegate: getAttributeDataProtocol!
    
    var data = Data()
    
    var typeTermsArray : [String] = []
    var destinationArray : [String] = []
    
    var URLPath: String = "http://turing.manhattan.edu/~mbogarin01/SNOMEDROID/attributes.php?id="
    
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
            print("attribute data:")
            print(error)
               
           }
           
           var jsonElement = NSDictionary()
       
        
        for i in 0 ..< jsonResult.count{
            
            jsonElement = jsonResult[i] as! NSDictionary
           //print("jsonelement: " , jsonElement)
            let location = Attribute()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let typeTerm = jsonElement["typeTerm"] as? String,
                let destination = jsonElement["destinationTerm"] as? String
            {
                location.type = typeTerm
                location.destination = destination
            }
            
            typeTermsArray.append(location.type!)
            destinationArray.append(location.destination!)
        }
        
        
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.typeTermDownloaded(type: self.typeTermsArray)
            self.delegate.destinationDownloaded(destination: self.destinationArray)
        })
    }

}
