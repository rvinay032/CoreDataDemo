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
    
    var userArr = [Users]()
    
    
    // %%%%%%%%%%% View Methods %%%%%%%%%%%%
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnTap = true
        
    }
    
    
    
    // %%%%%%%%%%  Search Btn Action %%%%%%%%%%%%%%%%%%%%%
    @IBAction func searchBtnTap(_ sender: UIButton) {
        
        guard let searchScene = self.storyboard?.instantiateViewController(withIdentifier: "SearchVCId") as? SearchVC else {fatalError("unable to  pass")}
        
        self.navigationController?.pushViewController(searchScene, animated: true)
        
    }
    
    // %%%%%%%%%%  ADD Btn Action %%%%%%%%%%%%%%%%%%%%%
    
    @IBAction func addButtonTap(_ sender: UIButton) {
        
        guard let addScene = self.storyboard?.instantiateViewController(withIdentifier: "ViewControllerId") as? ViewController else {fatalError("unable to  pass")}
        
        self.navigationController?.pushViewController(addScene, animated: true)
        
    }
    
    // %%%%%%%%%%  FETCH Btn Action %%%%%%%%%%%%%%%%%%%%%
    
    @IBAction func fetchButtonTap(_ sender: UIButton) {
        
        // &&&&&&&&&&&&  Call Fetch Method &&&&&&&&&&&&&
        
        guard let fetchScene = self.storyboard?.instantiateViewController(withIdentifier: "DataShowVCId") as? DataShowVC else {fatalError("unable to  pass")}
        
        fetchScene.userarr12 = CoreDataManager.fetch()
        
        self.navigationController?.pushViewController(fetchScene, animated: true)
        
    }
    
    
    
}
