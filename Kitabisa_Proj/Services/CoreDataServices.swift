//
//  CoreDataServices.swift
//  Kitabisa_Proj
//
//  Created by Abigail Aryaputra Sudarman on 17/10/21.
//

import Foundation
import CoreData
import UIKit


///This class handle all core data  operation within this app
class CoreDataServices{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    ///Delete certain movie from favorite
    func deleteFromFavorite(movieID: Int){
        // Create a fetch request with a predicate
        let fetchRequest: NSFetchRequest<FavoriteMovie>
        fetchRequest = FavoriteMovie.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "movieID == %d", movieID)

        // Setting includesPropertyValues to false means
        // the fetch request will only get the managed
        // object ID for each object
        fetchRequest.includesPropertyValues = false

      
        do{
        // Perform the fetch request
        let objects = try context.fetch(fetchRequest)
            
        // Delete the objects
        for object in objects {
            context.delete(object)
        }

        // Save the deletions to the persistent store
        try context.save()
        } catch {
            print("ERROR DELETING MOVIE")
        }
    }
    
    ///Load from core data
    func getFavorites(completion: @escaping (Result<[FavoriteMovie], Error>) -> Void) {// Create a fetch request for a specific Entity type
        let fetchRequest: NSFetchRequest<FavoriteMovie>
        fetchRequest = FavoriteMovie.fetchRequest()


        // Fetch all objects of one Entity type
        do{
        let objects = try context.fetch(fetchRequest)
            completion(.success(objects))
        } catch let error {
            completion(.failure(error))
            print("ERROR FETCHING FAVORITES FROM CORE DATA")
        }
    }
    
    ///Check if movie is favorite
    func isMovieFavorite (movieID: Int) -> Bool{
        
        // Configure a fetch request to fetch at most 1 result
        let fetchRequest = NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "movieID == %d", movieID)
        // Fetch a single object. If the object does not exist,
        // nil is returned
        
        
        //Check if movie id exist in favorite list
        do{
            if let object = try context.fetch(fetchRequest).first {
                print("Found in favorite")
                return true
            } else {
                print("Not found in favorite")
                return false
            }
        } catch {
            
        }
        return false
    }
    
    ///Save a movie to favorite with Core Data persistent storage
    func saveToFavorite (movieID: Int, overview: String, releaseDate: String, title: String, imageData: Data) {
        let entity =
        NSEntityDescription.entity(forEntityName: "FavoriteMovie",
                                   in: context)!
        
        let movie = NSManagedObject(entity: entity,
                                     insertInto: context)
        
        
        //Set values
        movie.setValue(movieID, forKeyPath: "movieID")
        movie.setValue(overview, forKey: "overview")
        movie.setValue(releaseDate, forKey: "releaseDate")
        movie.setValue(title, forKey: "title")
        movie.setValue(imageData, forKey: "imageData")
        
        print(movie)
        // 4
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    ///Clear favorite list for debug purposes
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
