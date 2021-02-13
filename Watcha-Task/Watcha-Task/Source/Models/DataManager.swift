//
//  DataManager.swift
//  Watcha-Task
//
//  Created by 이주혁 on 2021/02/12.
//

import CoreData
import Foundation


public class DataManager {
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AppData")
        container.loadPersistentStores{ (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    public func fetchData(as state: ImageState) -> [String] {
        var result: [String] = []
        do {
            let request: NSFetchRequest = Likes.fetchRequest()
            request.predicate = NSPredicate(format: "i_State == %@", state.rawValue)
            let images = try context.fetch(request)
            result = images.compactMap{ return $0.i_ID }.filter{ return $0.count != 0}
        }
        catch {
            return result
        }
        return result
    }
    
    public func isAlreadyLike(id: String) -> Bool {
        do {
            let request: NSFetchRequest = Likes.fetchRequest()
            request.predicate = NSPredicate(format: "i_ID == %@", id)
            
            let images = try context.fetch(request)
            if images.count > 0 {
                return true
            }
        }
        catch {
            return false
        }
        
        return false
    }
    
    public func putLike(id: String, state: ImageState) -> Bool {
        
        return isAlreadyLike(id: id) ? delete(id: id, state: state) : save(id: id, state: state)
    }
    
    private func delete(id: String, state: ImageState) -> Bool {
        do {
            let request: NSFetchRequest = Likes.fetchRequest()
            request.predicate = NSPredicate(format: "i_ID == %@", id)
            
            let result = try context.fetch(request)
            if let _ = result.first {
                context.delete(result.first!)
                
                try context.save()
                return true
            }
        }
        catch {
            return false
        }
        
        return false
    }
    
    private func save(id: String, state: ImageState) -> Bool {
        let entity = NSEntityDescription.entity(forEntityName: "Likes", in: context)
        
        if let entity = entity {
            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
            managedObject.setValue(id, forKey: "i_ID")
            managedObject.setValue(state.rawValue, forKey: "i_State")
            
            do {
                try self.context.save()
                return true
                
            } catch {
                print(error.localizedDescription)
                return false
                
            }
        }
        
        return false
        
    }
}
