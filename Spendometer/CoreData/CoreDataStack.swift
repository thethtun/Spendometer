//
//  CoreDataStack.swift
//  Spendometer
//
//  Created by Thet Htun on 7/20/21.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    let persistentContainer : NSPersistentContainer
    
    var context : NSManagedObjectContext {
        get {
            return persistentContainer.viewContext
        }
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Spendometer")

        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data store failed to load with error: \(error)")
            }
        }
    }
    
    func saveContext(completion: @escaping () -> Void) {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        completion()
    }

}
