//
//  DataBaseService.swift
//  NewsApp
//
//  Created by jsmirnova on 17.12.17.
//  Copyright © 2017 jsmirnova. All rights reserved.
//

import Foundation
import CoreData

// нужно перенести этот enum
enum EntitiesName: String {
    case news = "NewsItem"
}

enum EntitiesProperties: String {
    static let all = [content, dateCreate, dateModified, id, title]
    case content
    case dateCreate
    case dateModified
    case id
    case title
}

class DataBaseService: NSObject {
    
    typealias Entity = [EntitiesProperties: Any]
    
   fileprivate lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
   fileprivate lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "NewsApp", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("NewsApp.sqlite")
        
        var failureReason = "There was an error creating or loading the application's saved data."
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    fileprivate lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    fileprivate func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
}

// MARK: SAVE
extension DataBaseService {
    
    func saveItems(_ items: [Entity], withName entityName: EntitiesName) {
        for item in items {
            saveItem(item, withName: entityName, needToSaveToDisk: false)
        }
        saveContext()
    }
    
    func saveItem(_ item: Entity, withName entityName: EntitiesName) {
        saveItem(item, withName: entityName, needToSaveToDisk: true)
    }
    
    
    private func saveItem (_ item: Entity, withName entityName: EntitiesName, needToSaveToDisk: Bool) {
        let newsManagedObject = createNewManagedObject(withName: entityName)
        for key in item.keys {
            if let value = item[key] {
                newsManagedObject.setValue(value, forKeyPath: key.rawValue)
            }
        }
        
        if needToSaveToDisk {
            saveContext()
        }
    }
    
    
    private func createNewManagedObject(withName entityName: EntitiesName) -> NSManagedObject {
        let newEntity = NSEntityDescription.entity(forEntityName: entityName.rawValue, in: managedObjectContext)!
        let managedObject = NSManagedObject(entity: newEntity,
                                            insertInto: managedObjectContext)
        return managedObject
    }
}

// MARK: GET
extension DataBaseService {
    
    func getEntities(withName name: EntitiesName) -> [Entity]? {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: name.rawValue)
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            let entites = objects.map{$0.getEntity(withName: name)}
            return entites
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    func getEntity(with name: EntitiesName) -> Entity? {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: name.rawValue)
        do {
            let objects = try managedObjectContext.fetch(fetchRequest)
            let entites = objects.map{$0.getEntity(withName: name)}
            if let entity = entites.filter{$0.valueForKey()}
            return entites
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
