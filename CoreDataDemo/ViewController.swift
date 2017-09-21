//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {

    // Arrays Declaration--------------
    
    var userArr = [String]()
    var passArr = [String]()
    
    var filteredData = [String]()
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var fetchBtnout: UIButton!
    
    @IBOutlet weak var saveBtnOut: UIButton!
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var searchTableViewoutlet: UITableView!
    
    
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    
    
    // %%%%%%%%%%%%%%%%%%%%%%%% Save Button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    @IBAction func saveBtntap(_ sender: UIButton) {
        if !(userNameTextField.text == "" || passwordTextField.text == "")  {
            
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        
        newUser.setValue(userNameTextField.text, forKey: "userName")
        newUser.setValue(passwordTextField.text, forKey: "password")
        
        do
        {
            
            try context.save()
            print("SAVED")
        }
            
        catch
        {} ///////////// End.................
        
        let alert = UIAlertController(title: "Yipee!!", message: "Data is saved..", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func fetchBtnTap(_ sender: UIButton) {
       
        
        
        userArr.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        //// Fetching Data..................
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        do
        {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let username = result.value(forKey: "userName") as? String {
                      
                            userArr.append(username)
                        
                        
                    }
                    
                    if let password = result.value(forKey: "password") as? String {
                       
                        passArr.append(password)
                        
                    }
                    
                }
                print(userArr)
                print(passArr)
            }
        }
            
            
        catch
        {
            
        }// End...............
        
        
        guard let fetchScene = self.storyboard?.instantiateViewController(withIdentifier: "DataShowVCId") as? DataShowVC else {fatalError("unable to  pass")}
        
        fetchScene.arr = self.userArr
        fetchScene.passarr = self.passArr
        self.present(fetchScene, animated: true, completion: nil)
        
        
        
    }
    
    ////////////View Methods %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let nibCell = UINib(nibName: "CellOfSearchTableView", bundle: nil)
      searchTableViewoutlet.register(nibCell, forCellReuseIdentifier: "CellOfSearchTableViewId")
       
       searchTableViewoutlet.delegate = self
       searchTableViewoutlet.dataSource = self
       searchBarOutlet.delegate = self
        filteredData = userArr
        
        self.saveBtnOut.layer.cornerRadius =  self.saveBtnOut.frame.height/3
         self.saveBtnOut.clipsToBounds = true
        
        self.fetchBtnout.layer.cornerRadius =  self.fetchBtnout.frame.height/3
        self.fetchBtnout.clipsToBounds = true
        
        saveBtnOut.isEnabled = false
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("username array in DIDAPPEAR is \(userArr)")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }

    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfSearchTableViewId", for: indexPath) as? CellOfSearchTableView else {
            fatalError("unable to make cells")
        }
        cell.searchResultLabel.text = filteredData[indexPath.row]
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = searchText.isEmpty ? userArr : userArr.filter { (temp: String) -> Bool in
            
            return temp.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            
        }
      
        searchTableViewoutlet.reloadData()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        saveBtnOut.isEnabled = true
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        saveBtnOut.isEnabled = true
//
//    }
    
    
    
}

