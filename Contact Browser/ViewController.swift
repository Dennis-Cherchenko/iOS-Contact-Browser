//
//  ViewController.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/12/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
 
    var searchString = ""
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        //tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /////////////////////////////////////////////////////////////////////////
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        searchString = searchText
        getContacts()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        searchString = searchBar.text!
        getContacts()
    }
    
    
    
    /*
    
    // UITableViewDataSource Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel()
        label.text = "Hello Man"
        cell.addSubview(label)
        return cell
    }
    
    
    // UITableViewDelegate Functions
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    
    
    */
    
    
    private func getContacts() {
        
        
        let store = CNContactStore()
        
        //print(searchString)
        
        
        let predicate = CNContact.predicateForContacts(matchingName: searchString)
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        do{
            let contacts = try store.unifiedContacts(
                matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            for contact in contacts{
                print(contact.givenName)
                print(contact.familyName)
                
            }
            
        } catch let err{
            print(err)
        }
        
        
    }
    
    
}


