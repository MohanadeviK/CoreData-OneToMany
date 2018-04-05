//
//  Books+CoreDataClass.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//
//

import Foundation
import CoreData


public class Books: NSManagedObject {
    class func saveDetails(name : String, edition : Int16, publication : String, aboutBook : String) -> Books
    {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Books",
                                                 in:managedContext)
        let bookObj = NSManagedObject(entity: entity!,
                                      insertInto: managedContext) as! Books
        
        bookObj.name = name
        bookObj.edition = edition
        bookObj.pulication = publication
        bookObj.about = aboutBook
        
        do {
            try managedContext.save()
            print("person obj", bookObj)
            return bookObj
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return bookObj
    }
    
    class func fetchDetails()  -> [Books]?
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Books")
        do
        {
            let results =
                try managedContext.fetch(fetchRequest)
            return results as! [Books]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
    
    class func deleteOperation(individualBook: Books) -> Bool {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            managedContext.delete(individualBook)
            try managedContext.save()
        }  catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
    }
    
    class func updateContent(name : String, edition : Int16, publication : String, aboutBook: String, updatedBookObj : NSManagedObjectID) -> Bool
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let Book = managedContext.object(with: updatedBookObj)
        
        let bookObj = Book as! Books
        bookObj.name = name
        bookObj.edition = edition
        bookObj.pulication = publication
        bookObj.about = aboutBook
        do {
            try managedContext.save()
            return true
        }
        catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
        
    }
}
