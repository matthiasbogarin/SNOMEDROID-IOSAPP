//
//  HomeViewController.swift
//  SNOMEDROID
//
//  Created by Leon Wu on 3/21/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

//HomeViewControllerCode
class HomeViewController: UIViewController {
    //Creating the variables for the buttons on this view.
    @IBOutlet var SearchAllButton: UIButton!
    @IBOutlet var SearchByButton: UIButton!
    
    @IBOutlet var loadingLbl: UILabel!
    
    
    //create empty terms array
    var termsArray : [Terms] = []
    
    //the functions within this will load when the view loads.
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Setting up the design for all the elemts on the view.
        setUpElements()
        SearchByButton.isEnabled = false
        SearchAllButton.isEnabled = false
        loadingLbl.alpha = 1
        //Parse JSON DATA
        self.jsondataLoad()
    
        sleep(5)
    }

    //function that will use the Utilites.Swift file to run design functions on elements.
    func setUpElements()
    {
        Utilities.styleFilledButton(SearchAllButton)
        Utilities.styleFilledButton(SearchByButton)
    }
   
    @IBAction func HomeToSearch(_ sender: Any) {
        //segue to search view.
        
    }
    
    @IBAction func HomeToForms(_ sender: Any) {
        //segue to filter view.
        
    }
    
    
    //passing termsArray to the searchView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let viewController = segue.destination as? SearchViewController {
        viewController.termsArray = termsArray
        }
    if let viewController = segue.destination as? FiltersViewController {
           viewController.termsArray = termsArray
           }
    }
    
    //json function
    func jsondataLoad()
    {
    //setting url for JSON
        let jsonURLString = "https://turing.manhattan.edu/~xwu01/capstone/term.json";
        guard let url = URL(string: jsonURLString) else {
            return
        }
    //create url session
        URLSession.shared.dataTask(with: url) { (data,response,err) in
         //check err
            guard let data = data else {
                return
            }
            //if there is data, parse JSON data
        do{
                //parse json data
                let downloadedTerms = try JSONDecoder().decode([Terms].self, from: data)
    
                //store parsed json data into array
                for term in downloadedTerms
                {
                    self.termsArray.append(term)
                }
            }
        catch
        {
                print("An error has occured.")
        }
            
        DispatchQueue.main.async{
                   self.SearchAllButton.isEnabled = true
                   self.SearchByButton.isEnabled = true
                   self.loadingLbl.alpha = 0
               }
            
    }.resume()
    
    }
}
