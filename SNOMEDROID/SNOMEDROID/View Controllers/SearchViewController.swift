//
//  termsClass.swift
//  SNOMEDROID
//
//  Created by Leon Wu on 3/21/20.
//  Copyright © 2020 Matthias Bogarin. All rights reserved.
//

import UIKit

//View Controller 
class SearchViewController: UIViewController, UISearchBarDelegate{
    
    //declaring all outlets
    @IBOutlet weak var searchTableView: UITableView!
    
    //create filter array
    var filteredArray = [Terms]()
    
    //is search bar empty? Var (returns true or false)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    //create empty termsArray for data to be passed from HomeViewController
    var termsArray = [Terms]()
    
    //declaration for searchController
    var searchController = UISearchController(searchResultsController: nil)
    
    //determine if you're filtering results
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    
    //all these code will execute when the view is loaded, in the background.
    override func viewDidLoad()
    {
        //loads all the search bar functions when the view loads
        super.viewDidLoad()
        self.searchTableView.dataSource = self
        self.searchTableView.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Terms"
        self.definesPresentationContext = true
        self.searchTableView.tableHeaderView = self.searchController.searchBar
        searchController.searchBar.barStyle = .black
    }
    

    //using dispatchworkitem to execute search task, used for delay
    var searchTask: DispatchWorkItem?
    
    //search function
    func filterContentForSearchText(_ searchText: String) {
        //setting filteredArray to termsArray
        filteredArray = termsArray
        //if the field is not empty, set the filteredArray to termsArray containing to whatever the user inputs
        if searchText.isEmpty == false {
            filteredArray = termsArray.filter { (Terms) -> Bool in
            return Terms.term.range(of: searchText, options: [ .caseInsensitive ]) != nil
            }
        }
        //reload the tableView after with the new filteredArray
        searchTableView.reloadData()
    }
}

//SearchViewController Code
extension SearchViewController: UISearchResultsUpdating {
    //updating the search results calling the filterContentForSearchText function up top
    func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    self.searchTask?.cancel()
    let task = DispatchWorkItem { [weak self] in
        self?.filterContentForSearchText(searchBar.text!)
    }
    self.searchTask = task
    
    //adding delay of 0.75 seconds and executing the task after the user stops typing
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
    //prevent the search bar from going out after scrolling down the table
    navigationItem.hidesSearchBarWhenScrolling = false
  }
}

//searchViewController tableView code
extension SearchViewController: UITableViewDataSource, UITableViewDelegate{
    
    //defining how the data is going to be displayed in terms of content
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //use the prototype cell identifier in Main.storyboard searchView as the first cell
              let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? CellTableViewCell
        
        //if the isFiltering function is there, display only the filtered results
        if isFiltering{
            cell?.textLabel!.text = filteredArray[indexPath.row].term
            cell?.accessibilityLabel = String(filteredArray[indexPath.row].conceptId)
        
            //otherwise, display the entire terms array data
        }else{
            cell?.textLabel!.text = termsArray[indexPath.row].term
            cell?.accessibilityLabel = String(termsArray[indexPath.row].conceptId)
        }
            //return the cell to the tableView
        return cell!
        }
    
    //defining how long the table will be.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //if the isFiltering function is there, return only the number of rows of results that is filtered.
        if isFiltering{
            return filteredArray.count
        }
        //otherwise, return the number of rows of all terms.
        return termsArray.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        if isFiltering{
            vc?.conceptId = String(filteredArray[indexPath.row].conceptId)
        
            //otherwise, display the entire terms array data
        }else{
            vc?.conceptId = String(termsArray[indexPath.row].conceptId)
        }
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
