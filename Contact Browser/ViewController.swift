//
//  ViewController.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/12/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableview: UITableView!
 
    var searchString = ""
    
    var contactStore = CNContactStore()
    
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableview.dataSource = self
        tableview.delegate = self
        
        filtered = []
        
        showContacts(searchString: searchString)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /////////////////////////////////////////////////////////////////////////
    
    //Search Bar Functions
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        searchString = searchText
        showContacts(searchString: searchString)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        searchString = searchBar.text!
        showContacts(searchString: searchString)
    }
    
    /////////////////////////////////////////////////////////////////////////

    
    
    
    
    
    
    
    
    
    
    
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath as IndexPath)
        cell.textLabel?.text = filtered[indexPath.item]
        return cell
    }
    
    
    
    
    private func updateCells(_ tableView: UITableView, cellForRowAt indexPath: IndexPath){
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath as IndexPath)
        cell.textLabel?.text = filtered[indexPath.item]
        //return cell
        
        
        
    }
    
    

    
    
    
    private func showContacts(searchString: String){
    
        
        let store = CNContactStore()
        let predicate = CNContact.predicateForContacts(matchingName: searchString)
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        
        filtered = []
        
        print("Got Here")
    
        
        do{
            let contacts = try store.unifiedContacts( matching: predicate, keysToFetch: toFetch as [CNKeyDescriptor])
            
            do{
                
                print("Got Here 2")
                
                for contact in contacts{
                    print("Got Here3")
                    
                    
                    do{}
                    
                    
                    
                    //filtered.append(contact.givenName + " " + contact.familyName + "             " + ((contact.phoneNumbers[0].value)(forKey: "digits") as! String))
                    
                    
                    filtered.append(contact.givenName + " " + contact.familyName)
                    
                    
                    
                    
                    
                    
                    
                    
                    print(contact.givenName)
                    print(contact.familyName)
                    //print(contact.phoneNumbers[0])
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    print("Got Here 4")
                }
                
            }catch{
                print("ERROR")
            }
            
            self.tableview.reloadData()
            
        } catch let err{
            print(err)
        }
    
    }

    
    
    
}


