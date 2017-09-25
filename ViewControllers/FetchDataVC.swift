//
//  DataShowVC.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import CoreData

class DataShowVC: UIViewController {
    
    var userarr12 = [Users]()
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: "CellOfTableView", bundle: nil)
        tableViewOutlet.register(nibCell, forCellReuseIdentifier: "CellOfTableViewId")
        
        
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableViewOutlet.reloadData()
    }
    
}

extension DataShowVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userarr12.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CellOfTableViewId", for: indexPath) as? CellOfTableView else {fatalError("unable to make cell")}
        
        
        let userData = self.userarr12[indexPath.row]
        
        cell.emaillabel.text = userData.email
        cell.passwordLabel.text = userData.password
        cell.contactNoLabel.text = userData.contactNo
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select")
        
        guard let saveScene = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerId") as? ViewController else {fatalError("unable tp make object")}
        print("enter")
        
        saveScene.users = userarr12[indexPath.row]
        tableViewOutlet.reloadData()
        self.navigationController?.pushViewController(saveScene, animated: true)
    }
    
    
    
    
    //======= swipe method============
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let deleteButton = UITableViewRowAction(style: .normal,
                                                title: "Delete") { action, index in
                                                    
                                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                                    let context = appDelegate.persistentContainer.viewContext   //===============
                                                    
                                                    
                                                    context.delete(self.userarr12[editActionsForRowAt.row])
                                                    self.userarr12.remove(at: editActionsForRowAt.row)
                                                    tableView.deleteRows(at: [editActionsForRowAt],
                                                                         with: .automatic)
                                                    
                                                    let _ : NSError! = nil
                                                    do {
                                                        try context.save()
                                                        self.tableViewOutlet.reloadData()
                                                    } catch {
                                                        print("error : \(error)")
                                                    }
        }
        deleteButton.backgroundColor = .red
        
        
        //        //====== update Text button=========
        
        let update = UITableViewRowAction(style: .normal, title: "update") { action, index in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext   //===============
            
            guard let saveScene = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerId") as? ViewController else {fatalError("unable tp make object")}
            print("enter")
            
            saveScene.users = self.userarr12[editActionsForRowAt.row]
            context.delete(self.userarr12[editActionsForRowAt.row])
            self.tableViewOutlet.reloadData()
            self.navigationController?.pushViewController(saveScene, animated: true)
            
        }
        
        update.backgroundColor = .orange
        return [deleteButton, update]
    }
    
    
}
