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
    
    //Change
    
    
    
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self

        
        
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


