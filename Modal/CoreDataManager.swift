//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by appinventiv on 23/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    
    
    class func save(entityName : String, enterData: [String: String])  {
        
        var users: Users?
        if users == nil
        {
            
            // If u want to update the exiting Vaalue %%%%%%%%%%%%%%
            
            let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: managedObjectContext)
            users = Users(entity: userEntity!, insertInto: managedObjectContext)
            
        }
        
        users?.email = enterData["email"]
        users?.password = enterData["password"]
        users?.contactNo = enterData["contactNo"]
        
        // ........................................................
        
        
        do
        {
            try managedObjectContext.save()
            
            print("SAVED")
        }
            
        catch
        {} ///////////// End.................
        
    }
    
    class func fetch() -> [Users] {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        //// Fetching Data..................
        
        var userArray = [Users]()
        let request =  Users.userFetchRequestr()
        
        request.returnsObjectsAsFaults = false
        
        do
        {
            userArray.removeAll()
            let results = try context.fetch(request)
            
            for result in results{
                
                userArray.append(result)
            }
        }
            
        catch
        {
            
        }// End...............
        return userArray
    }
}
