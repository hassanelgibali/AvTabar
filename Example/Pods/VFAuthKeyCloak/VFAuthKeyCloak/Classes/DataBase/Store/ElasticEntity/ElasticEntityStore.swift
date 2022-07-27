//
//  ElasticEntityStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 05/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- ELASTIC STORE
@objc public class ElasticEntityStore: NSObject, CoreDataStore {
    
    //MARK:- PROPERTIES & INIT
    public var storage: CoreDataStorage
    var store: UserInfoEntityStoreProtocol
    
    public init(store: UserInfoEntityStoreProtocol, storage: CoreDataStorage) {
        self.store = store
        self.storage = storage
    }
    
    //MARK:- SAVE ELASTIC MODEL
    @objc public func saveElasticData(encodedData: Data, isPayment: Bool) {
        let newElasticModel = ElasticEntity(context: storage.privateContext)
        newElasticModel.encodedData = encodedData
        newElasticModel.isPayment = isPayment
        newElasticModel.createdAt = Date()
        newElasticModel.user = store.fetchCurrentUser()
        storage.saveContext()
    }
    
    //MARK:- FETCH ELASTIC MODEL
    @objc public func fetchSpecificErrorsFor(msisdn: String, count: Int) -> [ElasticEntity] {
        let predicate = NSPredicate(format: "%K == %@", "user.msisdn", store.fetchCurrentUser()?.msisdn ?? "")
        let sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        let models = storage.fetchEntity(entity: .elastic,
                                         predicate: predicate,
                                         count: count,
                                         sort: sortDescriptors) as? [ElasticEntity]
        return copyModels(models: models ?? [])
    }
    
    //MARK:- DELETE ELASTIC MODEL FOR CURRENT USER
    @objc public func deleteUserElasticModelForCurrentUser() {
        let predicate = NSPredicate(format: "%K == %@", "user.msisdn", store.fetchCurrentUser()?.msisdn ?? "")
        storage.batchDeleteEntity(entity: .elastic, for: predicate)
    }
    
    //MARK:- DELETE ALL ELASTIC MODELS
    @objc public func deleteAllElasticModels() {
        storage.batchDeleteEntity(entity: .elastic)
    }
}

//MARK:- ELASTIC STORE EXTENSION
extension ElasticEntityStore {
    
    //MARK:- COPY MODELS
    public func copyModels(models: [ElasticEntity]) -> [ElasticEntity] {
        var fetchedModels = [ElasticEntity]()
        for model in models {
            if let copiedModel = model.copy(context: storage.privateContext) {
                fetchedModels.append(copiedModel)
                storage.deleteEntityRow(row: model)
            }
        }
        return fetchedModels
    }
}
