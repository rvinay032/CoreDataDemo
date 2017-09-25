//
//  Users+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by appinventiv on 25/09/17.
//  Copyright © 2017 appinventiv. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func userFetchRequestr() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var dob: NSDate?
    @NSManaged public var password: String?
    @NSManaged public var email: String?
    @NSManaged public var contactNo: String?

}
