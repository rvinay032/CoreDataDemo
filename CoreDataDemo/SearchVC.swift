//
//  SearchVC.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import CoreData

class SearchVC: UIViewController {

    var filterData = [String]()
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
        filterData.removeAll()
        
       // textData.append(searchTextField.text!)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //// Fetching Data..................
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.predicate = NSPredicate(format: "userName == %@", searchTextField.text!)
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for temp in results as! [NSManagedObject] {
                    if let username = temp.value(forKey: "userName") as? String {
                        if username == searchTextField.text {
                            filterData.append(username)
                        }
                    }
                }
            }
            else {
                filterData.append("No User found")
            }
        }
        catch
        {
            print(error)
        }// End...............
        searchTableView.reloadSections([0], with: .automatic )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nibCell = UINib(nibName: "CellOfTableView", bundle: nil)
        searchTableView.register(nibCell, forCellReuseIdentifier: "CellOfTableViewId")
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filterData.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfTableViewId", for: indexPath) as? CellOfTableView
            else {
            fatalError()
        }
        cell.userNamelabel.text = filterData[indexPath.row]
        return cell
    }
    
    
    
}
