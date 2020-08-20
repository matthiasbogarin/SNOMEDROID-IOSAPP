//
//  FiltersViewController.swift
//  SNOMEDROID
//
//  Created by Matthias Bogarin on 3/30/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController{
    
    //create termArray to receive terms from HomeViewController
    var termsArray :[Terms] = []
    
    //create filteredArray to append terms to.
    var filteredArray :[Terms] = []
    
    //create termsArray1
    var termsArray1: [Terms] = []
    
   //create array to store all the hierarchical terms to be looped
    let arr : [[String]] = [["(body structure)", "(cell)","(cell structure)", "(morphological abnormality)"],["(finding)","(disorder)"],["(environment)","(geographic location)"],["(event)"],["(observable entity)"],["(organism)"],["(clinical drug)","(medicinal product)","(medicinal product form)","(physical object)","(product)"],["(physical force)"],["(procedure)","(regime/therapy)"],["(qualifier value)","(administration method)","(basic dose form)","(disposition)","(dose form)","(intended site)","(number)","(product name)","(release characteristic)","(role)","(state of matter)","(transformation)","(supplier)","(unit of presentation)"],["(record artifact)"],["(situation)"],["(attribute)","(core metadata concept)","(foundation metadata concept)","(link assertion)","(linkage concept)","(namespace concept)","(OWL metadata concept)"],["(social concept)"],["(ethnic group)"],["(life style)","(occupation)","(person)","(racial group)","(religion/philosophy)"],["(inactive concept)","(navigational concept)"],["(specimen)"],["(staging scale","(assessment scale)","(tumor staging)"],["(substance)"]]
    
    //creating boolean for passing data
    var isChecked: Bool = false
    
    //create outlet connection for all buttons and store it in an array (type is CheckBox class)
    @IBOutlet var collectionOfButtons:[CheckBox]!
    
    @IBOutlet var applybutton: UIButton!
    
    //load functions after view, which we don't need
    override func viewDidLoad() {
        super.viewDidLoad()
        
         termsArray1 = termsArray
        
        //initialize counter and set it to 0 for loop
        var counter: Int = 0
        //setting tags for buttons on viewdidload using the loop
        for button in collectionOfButtons
        {
            button.tag = counter
            counter+=1
        }
        
        Utilities.styleFilledButton(applybutton)
        
    }
    
    
    //filter the array based on checkbox after the button Apply is hit.
    @IBAction func filterToSearch(_ sender:Any) {
        //setting termsArray to termsArray1
        termsArray = termsArray1
        
        //emptying out filteredArray
        filteredArray = []
        
        //looping through all the checkboxes
        for v in collectionOfButtons
        {
            //if the box is checked, append the filtered results to filteredArray
            if v.isChecked
        {
            //creating boolean for passing data
            //getting the array of hierarchical terms and looping it
            let hierarchicalTermArr = arr[v.tag]
            //looping through all the terms in the array
            for term in hierarchicalTermArr
            {
                //appending all the matchin values of each string in the array and appending it to the filtered list
                filteredArray.append(contentsOf: termsArray.filter { (Terms) -> Bool in
                return Terms.term.range(of: term, options: [ .caseInsensitive ]) != nil
                })
            }
            isChecked = true
        }
        //debug in console
        else{
            }
        }
    }
    
    
    //passing the filtered termsArray to the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                //setting termsArray to filteredArray
                if isChecked
                {
                    termsArray = filteredArray
                }
                
                //passing data to the SearchViewController
                if let viewController = segue.destination as? SearchViewController {
                viewController.termsArray = termsArray
                }
            }
}



