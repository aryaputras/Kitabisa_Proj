//
//  CoreDataServices.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import Foundation
import CoreData
import UIKit

class CoreDataServices{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func isMovieFavorite (movieID: Int) -> Bool{
        
        // Configure a fetch request to fetch at most 1 result
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        fetchRequest.fetchLimit = 1
        
        // Get a reference to a NSManagedObjectContext
        
        // Fetch a single object. If the object does not exist,
        // nil is returned
        
        
        //Check if movie id exist in favorite list
        do{
            if let object = try context.fetch(fetchRequest).first {
                print("Found in favorite")
                return true
            }
        } catch {
            print("Not found in favorite")
            return false
        }
        return false
    }
    
    
    func saveToFavorite (movieID: Int) {
        let entity =
        NSEntityDescription.entity(forEntityName: "FavoriteMovie",
                                   in: context)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        person.setValue(movieID, forKeyPath: "movieID")
        
        // 4
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    func clearFavorite(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavoriteMovie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            // TODO: handle the error
        }
    }
    
    
    
}
