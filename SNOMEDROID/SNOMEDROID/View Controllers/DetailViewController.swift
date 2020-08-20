//
//  DetailViewController.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 4/1/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController , getFsnDataProtocol, getParentDataProtocol, getSynDataProtocol,getChildDataProtocol,getAttributeDataProtocol, UITableViewDataSource, UITableViewDelegate{
   
    //properties
    var conceptId = ""
    var fsnTerm: String = ""
   // var fsnSctid: String = ""
    var synArray: [String] = []
    var parentArray: [String] = []
    var typeTermArrayForAttr: [String] = []
    var destinationArrayForAttr: [String] = []
    var childArray: [String] = []
    
    //elements for view
    @IBOutlet var fsnLabel: UILabel!
    @IBOutlet var sctidLabel: UILabel!
    @IBOutlet var synTable: UITableView!
    @IBOutlet var parentTable: UITableView!
    @IBOutlet var childTable: UITableView!
    @IBOutlet var attributeTable: UITableView!
    
    

override func viewDidLoad() {
        super.viewDidLoad()
    
    //All the getData functions being called one by one.
    getFSN()
    sctidLabel.text = "SCTID: " + conceptId
    getSyn()
    getParent()
    getAttributes()
    getChild()

    }
    
    //FSN function
    func getFSN()
    {
        let dataForFSN = getFsnData()
           //getting & displaying data for FSN & SCTID Labels.
           dataForFSN.delegate = self
           dataForFSN.changeURLPath(id: conceptId)
           dataForFSN.downloadedItems()
    }
    
    //synonom function
    func getSyn(){
        //synonom functions
        self.synTable.dataSource = self
        self.synTable.delegate = self
        let dataForSyn = getSynData()
        //getting & displaying data for SYN table.
        dataForSyn.delegate = self
        dataForSyn.changeURLPath(id: conceptId)
        dataForSyn.downloadedItems()
    }
    
    //parent function
    func getParent(){
        self.parentTable.delegate = self
        self.parentTable.dataSource = self
        let dataForParent = getParentData()
        //Getting & displaying data for parent table.
        dataForParent.delegate = self
        dataForParent.changeURLPath(id: conceptId)
        dataForParent.downloadedItems()
    }
    
    //attribute function
    func getAttributes(){
        //attribute functions
        self.attributeTable.delegate = self
        self.attributeTable.dataSource = self
        let dataForAttribute = getAttributeData()
        //getting & displaying data for attributes table.
        dataForAttribute.delegate = self
        dataForAttribute.changeURLPath(id: conceptId)
        dataForAttribute.downloadedItems()
    }
    
    //child function
    func getChild(){
        self.childTable.delegate = self
        self.childTable.dataSource = self
        let dataForChild = getChildData()
        //getting & displaying data for child table.
        dataForChild.delegate = self
        dataForChild.changeURLPath(id: conceptId)
        dataForChild.downloadedItems()
    }
    
    
    
    //getFsnDataProtocol Members for getting data
    //fsn
    func termDownloaded(term: String) {
        fsnTerm = term
        //print(fsnTerm)
        fsnLabel.text = "Full Name: " + fsnTerm
    }
   
    //syn
    func synTermDownloaded(term: [String]) {
        synArray = term
        self.synTable.reloadData()
    }
    //parent
    func parentTermDownloaded(term: [String]) {
        parentArray = term
        self.parentTable.reloadData()
    }
    
    //attribute
    func typeTermDownloaded(type: [String]) {
        typeTermArrayForAttr = type
        self.attributeTable.reloadData()
    }
    //attribute
    func destinationDownloaded(destination: [String]) {
        destinationArrayForAttr = destination
        self.attributeTable.reloadData()
    }
    //child
    func childTermDownloaded(term: [String]){
        childArray = term
        self.childTable.reloadData()
    }
    
    
    //Table functions:
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        //Checks which table is calling the function to provide it the correct numberOfRowsInSection number.
        
        if tableView == self.synTable{
            count = synArray.count
        }
       
        if tableView == self.parentTable{
            count = parentArray.count
        }
       
        if tableView == self.attributeTable{
            count = typeTermArrayForAttr.count
        }
       
        if tableView == self.childTable{
            count = childArray.count
        }
        
        //returns that number to use in the other functions.
        return count!
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        //This is for multiple tables in one view, so that all data can be displayed seperately.
        //checks which table is calling the function so it can provide the proper cell to place the data into.
        
        if tableView == self.synTable{
            let cellIdentifier: String = "synCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            //uses the syn array to display data to its corresponding table cell.
            cell?.textLabel?.text = synArray[indexPath.row]
        }
        
        if tableView == self.parentTable {
            let cellIdentifier: String = "parCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
            //uses the parent array to display data to its corresponding table cell.
            cell?.textLabel?.text = parentArray[indexPath.row]
        }
        
        if tableView == self.attributeTable{
            let cellIdentifier: String = "attrCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            //uses the both of the attributes array to display data to its corresponding table cell.
            cell?.textLabel?.text = typeTermArrayForAttr[indexPath.row] + " -> " + destinationArrayForAttr[indexPath.row] 
        }
        
        if tableView == self.childTable{
            let cellIdentifier: String = "childCell"
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            
            //uses the child array to display data to its corresponding table cell.
            cell?.textLabel?.text = childArray[indexPath.row]
        }
        
        
        
        //returns that cell to its corresponding table.
        return cell!
    }
    
    
}





