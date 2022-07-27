//
//  CoreDataManager.swift
//  Ana Vodafone
//
//  Created by Yasmine on 2018-08-09.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import Foundation
import CoreData
import UIKit

//MARK:- CORE DATA MANAGER
@objc public final class CoreDataManager: NSObject, CoreDataStorage {
    
    //MARK:- PROPERTIES
    public static let shared = CoreDataManager()
    
    let identifier: String  = "com.Vodafone.VFAuthKeyCloakFramework"       //Framework bundle ID
    let modelName: String       = "VFCoreDataModel"                      //Model name
    private var managedObjectContext: NSManagedObjectContext?

    //MARK:- INIT
    private override init() {}
    
    //MARK:- CORE DATA STACK
    lazy public var privateContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context.undoManager = nil
        return context
    }()
    
    lazy public var mainManagedObjectContext: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let coreDataBundle = Bundle(for: type(of: self))
        let modelURL = coreDataBundle.urls(forResourcesWithExtension: "momd", subdirectory: "VFAuthKeyCloak.bundle")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL.first!)
        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        let fileManager = FileManager.default
        let storeName = "\(modelName).sqlite"
        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        let description = NSPersistentStoreDescription(url: persistentStoreURL)
        
        // LightWeight Migration for old database
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
