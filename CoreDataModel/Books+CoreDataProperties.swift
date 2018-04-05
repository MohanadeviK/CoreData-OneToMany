//
//  Books+CoreDataProperties.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//
//

import Foundation
import CoreData


extension Books {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Books> {
        return NSFetchRequest<Books>(entityName: "Books")
    }

    @NSManaged public var name: String?
    @NSManaged public var edition: Int16
    @NSManaged public var pulication: String?
    @NSManaged public var about: String?
    @NSManaged public var author: Author?

}
