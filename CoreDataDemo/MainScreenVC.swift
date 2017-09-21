//
//  MainScreenVC.swift
//  CoreDataDemo
//
//  Created by appinventiv on 20/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import UIKit
import CoreData

class MainScreenVC: UIViewController {
    
    var userArr = [String]()
    var passArr = [String]()
    
    
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
        guard let searchScene = self.storyboard?.instantiateViewController(withIdentifier: "SearchVCId") as? SearchVC else {fatalError("unable to  pass")}
        
        self.navigationController?.pushViewController(searchScene, animated: true)
        
    }
    
    @IBAction func addButtonTap(_ sender: UIButton) {
        
        guard let addScene = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerId") as? ViewController else {fatalError("unable to  pass")}
        
       self.navigationController?.pushViewController(addScene, animated: true)
        
        }
    
    
    @IBAction func fetchButtonTap(_ sender: UIButton) {
        
        userArr.removeAll()
        
        fetchData()
        
        guard let fetchScene = self.storyboard?.instantiateViewController(withIdentifier: "DataShowVCId") as? DataShowVC else {fatalError("unable to  pass")}
        
        fetchScene.arr = self.userArr
        fetchScene.passarr = self.passArr
        self.navigationController?.present(fetchScene, animated: true, completion: nil) 
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func fetchData () {
        
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
        
    }
    
}
