//
//  CoreDataStorage.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 06/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation
import CoreData

//MARK:- DATABASE ENTITIES
public enum Entities: String {
    case userInfo = "UserInfoEntity"
    case apiModel = "APIModelsEntity"
    case elastic = "ElasticEntity"
    case flags = "UserFlagsEntity"
}

//MARK:- CORE DATA STORAGE
public protocol CoreDataStorage {
    
    //MARK: PROPERTIES
    var mainManagedObjectContext: NSManagedObjectContext { get }
    var privateContext: NSManagedObjectContext { get }
    
    //MARK: METHODS
    func saveContext()
    func fetchEntity<T: NSManagedObject>(entity: Entities, predicate: NSPredicate?, count: Int, sort: [NSSortDescriptor]?) -> [T]?
    func batchUpdateEntity(entity: Entities, propertiesToUpdate: [String:Any], for predicate: NSPredicate?)
    func batchDeleteEntity(entity: Entities, for predicate: NSPredicate?)
    func deleteEntityRow(row: NSManagedObject)
}

//MARK:- CORE DATA STORAGE EXTENSION
extension CoreDataStorage {
    
    //MARK:- SAVE
    public func saveContext() {
        if privateContext.hasChanges {
            do {
                try privateContext.save()
            } catch {
                let coreDataError = error as NSError
                fatalError("Unresolved error \(coreDataError), \(coreDataError.userInfo)")
            }
        }
    }
    
    //MARK:- FETCH
    public func fetchEntity<T: NSManagedObject>(entity: Entities, predicate: NSPredicate?, count: Int, sort: [NSSortDescriptor]?) -> [T]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity.rawValue)
        fetchRequest.sortDescriptors = sort
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = count
        do {
            if let object = try privateContext.fetch(fetchRequest) as? [T] {
                return object
            }
        } catch {
            let coreDataError = error as NSError
            fatalError("Unresolved error \(coreDataError), \(coreDataError.userInfo)")
        }
        return nil
    }
    
    //MARK:- update properties in entity if value is of type transformable you should archive it to data first
    public func batchUpdateEntity(entity: Entities, propertiesToUpdate: [String:Any], for predicate: NSPredicate?) {
        let updateRequest = NSBatchUpdateRequest(entityName: entity.rawValue)
        updateRequest.propertiesToUpdate = propertiesToUpdate
        updateRequest.resultType = .updatedObjectIDsResultType
        updateRequest.predicate = predicate
        do {
            if let result = try privateContext.execute(updateRequest) as? NSBatchUpdateResult, let objectIDArray = result.result as? [NSManagedObjectID] {
                let changes = [NSUpdatedObjectsKey : objectIDArray]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes,
                                                    into: [mainManagedObjectContext])
            }
        } catch {
            let coreDataError = error as NSError
            fatalError("Unresolved error \(coreDataError), \(coreDataError.userInfo)")
        }
    }
    
    //MARK:- DELETE
    public func batchDeleteEntity(entity: Entities, for predicate: NSPredicate?) {
        let records = NSFetchRequest<NSFetchRequestResult>(entityName: entity.rawValue)
        records.predicate = predicate
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: records)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        do {
            let batchDeleteResult = try privateContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
            if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave:[NSDeletedObjectsKey: deletedObjectIDs],
                                                    into: [mainManagedObjectContext])
            }
        } catch {
            let coreDataError = error as NSError
            fatalError("Unresolved error \(coreDataError), \(coreDataError.userInfo)")
        }
    }
    
    //MARK:- DELETE ROW
    public func deleteEntityRow(row: NSManagedObject) {
        privateContext.delete(row)
        saveContext()
    }
}

extension CoreDataStorage {
    
    public func fetchEntity<T: NSManagedObject>(entity: Entities, for predicate: NSPredicate? = nil) -> [T]? {
        return fetchEntity(entity: entity, predicate: predicate, count: Int.max, sort: nil)
    }
    
    public func batchUpdateEntity(entity: Entities, propertiesToUpdate: [String : Any]) {
        batchUpdateEntity(entity: entity, propertiesToUpdate: propertiesToUpdate, for: nil)
    }
    
    public func batchDeleteEntity(entity: Entities) {
        batchDeleteEntity(entity: entity, for: nil)
    }
    
    public func transformableToData(propertiesToUpdate: [String:Any]) -> [String : Any]{
        var archivedProperties = [String:Any]()
        for (key,value) in propertiesToUpdate {
            let transformedData: Data = NSKeyedArchiver.archivedData(withRootObject:value)
            archivedProperties[key] = transformedData
        }
        return archivedProperties
    }
}
