//
//  Author+CoreDataClass.swift
//  CoreDataOneToManyRelationship
//
//  Created by Devi on 05/04/18.
//  Copyright © 2018 Test. All rights reserved.
//
//

import Foundation
import CoreData


public class Author: NSManagedObject {
    class func saveDetails(name : String, age : Int16, native : String, about : String, bookObj : Books) -> Author
    {
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Author",
                                                 in:managedContext)
        let authorObj = NSManagedObject(entity: entity!,
                                        insertInto: managedContext) as! Author
        
        authorObj.name = name
        authorObj.age = age
        authorObj.native = native
        authorObj.aboutAuthor = about
        authorObj.addToBooks(bookObj)
        do {
            try managedContext.save()
            print("person obj", authorObj)
            return authorObj
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return authorObj
    }
    
    // chage
    class func linkExistingAuthorWithBook(book:Books, autherId : NSManagedObjectID)
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let author = managedContext.object(with: autherId)
        
        let authorObj = author as! Author
        authorObj.addToBooks(book)
        
        do {
            try managedContext.save()
            //            return authorObj
        }
        catch let error as NSError
        {
            print("Could not link \(error), \(error.userInfo)")
            //            return nil
        }
        
    }
    
    class func updateContent(name : String, age : Int16, aboutAuthor : String, native: String, updatedAuthorObj : NSManagedObjectID) -> Bool
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let author = managedContext.object(with: updatedAuthorObj)
        
        let authorObj = author as! Author
        authorObj.name = name
        authorObj.age = age
        authorObj.aboutAuthor = aboutAuthor
        authorObj.native = native
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
    
    class func deleteOperation(bookObj : Books) -> Bool {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity =  NSEntityDescription.entity(forEntityName: "Author",
                                                 in:managedContext)
        let authorObj = NSManagedObject(entity: entity!,
                                        insertInto: managedContext) as! Author
        do {
            authorObj.removeFromBooks(bookObj)
            managedContext.delete(bookObj)
            try managedContext.save()
        }  catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        return true
    }
    
    class func fetchDetails()  -> [Author]
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Author")
        var results = [Any]()
        do {
            results =
                try managedContext.fetch(fetchRequest)
            print("results", results)
            if results.count > 0 {
                return results as! [Author]
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return results as! [Author]
    }
    
    class func fetchBookCount(authorName : String)  -> Int?
    {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Author")
        let predicate = NSPredicate(format: "name = %@", authorName)
        fetchRequest.predicate = predicate
        do {
            //Change
            if let authorsData =
                try managedContext.fetch(fetchRequest) as? [Author], authorsData.count > 0
            {
                return authorsData.first?.books?.count
            }
            
            return 0
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return nil
    }
}
