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
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var topLabel: UILabel!
 
    var searchString = ""
    
    var contactStore = CNContactStore()
    
    var filtered:[(fullName: String, phoneNumber: String)] = []


    
    var importedContacts = People()
    
    var selectedContactFirstName = ""
    var selectedContactLastName = ""
    var selectedContactPhoneNumber = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        tableview.dataSource = self
        tableview.delegate = self
        

        initializeContactsFromCNContacts()
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
        if(searchString == ""){
            self.topLabel.text = "All Contacts"
        }else{
            self.topLabel.text = "Results for '" + searchString + "'"
        }
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath ) as! TableViewCell
        
        
       cell.name.text = filtered[indexPath.row].fullName
        cell.number.text = filtered[indexPath.row].phoneNumber
        return cell
    }
    
    
    
    func cleanPhoneNumber(number: String) -> String{
        return (number.components(separatedBy: NSCharacterSet.decimalDigits.inverted)).joined(separator: "")
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contactMessage =  "Would you like to contact " +  filtered[indexPath.row].0 + " at number: " + filtered[indexPath.row].1 + " ?"
        
        let alert = UIAlertController(title: contactMessage, message: filtered[indexPath.row].0, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
            case .default:

                let phone = "tel://" + self.cleanPhoneNumber(number: self.filtered[indexPath.row].1)

                let url:NSURL = NSURL(string:phone)!
                UIApplication.shared.openURL(url as URL)
                print("call success")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("canceled success")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            }
        }))
                
                
        self.present(alert, animated: true, completion: nil)
    }

    
    
    private func initializeContactsFromCNContacts(){

        let contactStore = CNContactStore()
        
        do {
            let fetchRequest = CNContactFetchRequest(keysToFetch: [CNContactGivenNameKey as CNKeyDescriptor, CNContactFamilyNameKey as CNKeyDescriptor, CNContactPhoneNumbersKey as CNKeyDescriptor])
            
            
            
            try! contactStore.enumerateContacts(with: fetchRequest) { contact, stop in
                
                if (!contact.phoneNumbers.isEmpty) {
                    
                    self.importedContacts.people.append(["firstName": contact.givenName,
                                                  "lastName": contact.familyName,
                                                  "phoneNumber": contact.phoneNumbers[0].value.stringValue])
                    self.tableview.reloadData()
                }
            }
            
            
        }catch{
            print("ERROR")
        }
        
        
        print(importedContacts.people[5])
    }
    
    private func checkIfContains(person: Dictionary<String, String>, searchString: String) -> Bool
    {
        if(person["firstName"]!.contains(searchString)){
            return true
        }else if(person["lastName"]!.contains(searchString)){
            return true
        }else{
            return false
        }
    }
    
    
    private func showContacts(searchString: String){
        
        filtered = []

        for person in importedContacts.people{

            if person["phoneNumber"] != nil{

                if searchString == ""{
                    
                    self.filtered.append((fullName: person["firstName"]! + " " + person["lastName"]!, phoneNumber: person["phoneNumber"]!))


                } else if checkIfContains(person: person, searchString: searchString){

                    self.filtered.append((fullName: person["firstName"]! + " " + person["lastName"]!, phoneNumber: person["phoneNumber"]!))
                }
            }

        }
        
        self.tableview.reloadData()
    }
    

    
    
    
}


