//
//  PersistenceManager.swift
//  RocketCoreTestApp
//
//  Created by Serj Rubens on 09.12.2020.
//

import Foundation
import CoreData

class PersistenceManager {
    private init() {}
    static let shared = PersistenceManager()
    
    // MARK: -
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RocketCoreTestApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("[PersistenceManager] Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
}

extension PersistenceManager {
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("[PersistenceManager] Saved successfully")
            } catch {
                let nserror = error as NSError
                fatalError("[PersistenceManager] Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ objectType: T.Type) -> [T] {
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let fetchedObjects = try context.fetch(fetchRequest) as? [T]
            return fetchedObjects ?? [T]()
        }
        catch {
            print("[PersistenceManager] Failed to fetch data: \(error)")
            return [T]()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
}
