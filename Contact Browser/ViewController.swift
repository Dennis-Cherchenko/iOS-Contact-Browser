//
//  ViewController.swift
//  Contact Browser
//
//  Created by Dennis Cherchenko on 9/12/16.
//  Copyright © 2016 Dennis Cherchenko. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Variables
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var topLabel: UILabel!

    // TODO: How to organize the networking files


    var searchString = ""
    var contacts: Contacts = Contacts()
    var filtered: [PersonInformation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let store = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {

        case .notDetermined:
            store.requestAccess(for: .contacts){succeeded, err in
                guard err == nil && succeeded else{
                    return
                }
                print("case not determined")
            }

        case .authorized:

            initializeView()
            contacts.initializeContacts()
            showContacts(searchString: searchString)
            print("success")

        default:
            print("Not handled")
            alert(message: "hello")

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
        let alert = UIAlertController(title: "Please allow contact browser to access contacts", message: "", preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:

                UIApplication.shared.openURL(NSURL(string:UIApplicationOpenSettingsURLString)! as URL)

            case .cancel: print() case .destructive: print()
                
            }
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    private func initializeView() {
        searchBar.delegate = self
        tableview.dataSource = self
        tableview.delegate = self
        self.tableview.reloadData()
    }
    


    
    
    // MARK: searchBar functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchText
        showContacts(searchString: searchString)
        if(searchString == ""){
            self.topLabel.text = "All Contacts"
        }else{
            self.topLabel.text = "Results for '" + searchString + "'"
        }
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchString = searchBar.text!
        showContacts(searchString: searchString)
    }
    


    
    // MARK tableView Functions
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customcell", for: indexPath ) as! TableViewCell
        cell.name.text = filtered[indexPath.row].fullName
        cell.number.text = filtered[indexPath.row].phoneNumber
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let contactMessage =  "Would you like to contact " +  filtered[indexPath.row].fullName + " at number: " + filtered[indexPath.row].phoneNumber + " ?"

        let alert = UIAlertController(title: contactMessage, message: filtered[indexPath.row].firstName, preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            switch action.style{
            case .default:

                let phone = "tel://" + self.cleanPhoneNumber(number: self.filtered[indexPath.row].phoneNumber)

                UIApplication.shared.openURL(NSURL(string:phone)! as URL)

            case .cancel: print() case .destructive: print()

            }
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in
            switch action.style{ case .default:print() case .cancel: print() case .destructive: print()}
        }))


        self.present(alert, animated: true, completion: nil)
    }


    func alert(message: String) {

        let alert = UIAlertController(title: message, message: "", preferredStyle: UIAlertControllerStyle.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in })

        self.present(alert, animated: true, completion: nil)

    }


    // MARK: Additional Functions


    func cleanPhoneNumber(number: String) -> String {
        return (number.components(separatedBy: NSCharacterSet.decimalDigits.inverted)).joined(separator: "")
    }

    private func checkIfContains(person: PersonInformation, searchString: String) -> Bool {
        return person.fullName.contains(searchString) || person.phoneNumber.contains(searchString)
    }
    
    
    private func showContacts(searchString: String) {
        
        filtered = []

        for person in contacts.contacts!{
            if searchString == "" || checkIfContains(person: person, searchString: searchString) {
                filtered.append(person)
            }
        }
        
        self.tableview.reloadData()
    }

}
