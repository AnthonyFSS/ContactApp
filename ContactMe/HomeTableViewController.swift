//
//  HomeTableViewController.swift
//  ContactMe
//
//  Created by Foo Shyang Song on 09/08/2018.
//  Copyright © 2018 AnthonyFoo. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {
    let cellId = "cellId"
    var contactViewModels = [ContactViewModel]()
    let names = ["Adam", "Bill", "Charles", "Don", "Eric", "Harry", "Ivan"]
    let namesTwo = ["Anthony","Antonio","Alibaba"]
    let sections = ["A","B","C"]

    let blabla = [["Anthony","Antonio","Alibaba"],["Adam", "Bill", "Charles", "Don", "Eric", "Harry", "Ivan"]]

    private let persistentContainer = NSPersistentContainer(name: "ContactMe")
    
    // MARK: -
    
    fileprivate lazy var fetchedResultsController: NSFetchedResultsController<Contact> = {
        // Create Fetch Request
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        
        // Configure Fetch Request
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "first_name", ascending: true)]
        
        // Create Fetched Results Controller
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func loadData() {
        persistentContainer.loadPersistentStores { (persistentStoreDescription, error) in
            if let error = error {
                print("Unable to Load Persistent Store")
                print("\(error), \(error.localizedDescription)")
                
            } else {
                self.setupView()
                
                do {
                    try self.fetchedResultsController.performFetch()
                } catch {
                    let fetchError = error as NSError
                    print("Unable to Perform Fetch Request")
                    print("\(fetchError), \(fetchError.localizedDescription)")
                }
                
                self.updateView()
            }
        }
    }
    
    
    fileprivate func updateView() {
        var hasContacts = false
        
        if let contacts = fetchedResultsController.fetchedObjects {
            hasContacts = contacts.count > 0
        }
        
        tableView.isHidden = !hasContacts
        
        //activityIndicatorView.stopAnimating()
    }
    
    
    
    private func setupView() {
        
        updateView()
    }
    
    // MARK: -

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let contacts = fetchedResultsController.fetchedObjects else { return 0 }
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reuseIdentifier, for: indexPath) as? ContactCell else {
            fatalError("Unexpected Index Path")
        }
        // Fetch Quote
        let contactData = fetchedResultsController.object(at: indexPath)
        // Configure Cell
        print(contactData.first_name)

        cell.profileName.text = contactData.first_name
        let baseUrl = "http://gojek-contacts-app.herokuapp.com"
        if contactData.profile_pic != nil {
            let profileUrl = baseUrl + contactData.profile_pic!
//            let url = URL(string: profileUrl)
//            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//            cell.profileImage.image = UIImage(data: data!)
            
            let url = URL(string: profileUrl)
            
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    if data != nil {
                        let profileImage = UIImage(data: data!)
                        cell.profileImage.image = profileImage
                        cell.profileImage.layer.borderWidth = 1.0
                        cell.profileImage.layer.masksToBounds = false
                        cell.profileImage.layer.borderColor = UIColor.white.cgColor
                        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.size.width / 2
                        cell.profileImage.clipsToBounds = true
                    } else {
                        
                    }
                    
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destinationViewController = segue.destination as? AddQuoteViewController else { return }
//
//        // Configure View Controller
//        destinationViewController.managedObjectContext = persistentContainer.viewContext
//
//        if let indexPath = tableView.indexPathForSelectedRow, segue.identifier == segueEditQuoteViewController {
//            // Configure View Controller
//            destinationViewController.quote = fetchedResultsController.object(at: indexPath)
//        }
    }
    
    
    fileprivate func fetchData() {
        Service.shared.fetchContact { (contacts, err) in
            if let err = err {
                print("Failed to fetch courses:", err)
                return
            }
            
            guard let entity = NSEntityDescription.entity(forEntityName: "Contact", in: context) else {
                fatalError("Could not find entity description")
            }
            
            for i in 0..<contacts!.count{
                print(contacts![i])
              let contactI = contacts![i] as! ContactStruct
            
            let newContact = NSManagedObject(entity: entity, insertInto: context)
            newContact.setValue(contactI.favorite, forKey: "favorite")
            newContact.setValue(contactI.first_name, forKey: "first_name")
            newContact.setValue(contactI.last_name, forKey: "last_name")
            newContact.setValue(contactI.id, forKey: "id")
            newContact.setValue(contactI.profile_pic, forKey: "profile_pic")
            newContact.setValue(contactI.url, forKey: "url")
            
                do {
                    try context.save()
                    print("saved")
                } catch {
                    print("Failed saing")
                }
            
            }
            
            self.contactViewModels  = contacts?.map({return ContactViewModel(contact: $0)}) ?? []
        }
    }

    
    @objc func handleShowIndexPath(){
//        var indexPathToReload = [IndexPath]()
//
//        for section in blabla.indices{
//
//            for row in blabla[section].indices {
//                print(section,row)
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Custom Delegation
    func someMethod(cell: UITableViewCell){
        
        let indexPathClicked = tableView.indexPath(for: cell)
        
        //let name = blabla[indexPathClicked!.section][indexPathClicked!.row]
        //print(name)
    }

    fileprivate func setupTableView() {
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        tableView.separatorColor = .mainTextBlue
        tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupNavBar() {
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .yellow
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 255, g: 129, b: 9)
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
    }
}

extension HomeTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
        
        updateView()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        default:
            print("...")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
    }
    
}


class CustomNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
    static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

