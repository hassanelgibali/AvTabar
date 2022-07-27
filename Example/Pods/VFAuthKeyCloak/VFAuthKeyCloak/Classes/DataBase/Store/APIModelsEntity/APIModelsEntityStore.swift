//
//  APIModelsEntityStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 9/16/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- API MODELS STORE
@objc public class APIModelsEntityStore: NSObject, CoreDataStore {
    
    //MARK:- PROPERTIES & INIT
    public var storage: CoreDataStorage
    public var store: UserInfoEntityStoreProtocol
    
    init(store: UserInfoEntityStoreProtocol, storage: CoreDataStorage) {
        self.store = store
        self.storage = storage
    }
    
    //MARK:- SAVE API MODEL RESPONSE
    @objc func saveResponse(JsonString: String, key: String, cacheType: CacheType) {
        let apiModel = APIModelsEntity(context: storage.privateContext)
        apiModel.jsonString = JsonString
        apiModel.time = getCurrentTime()
        let user = store.fetchUserByCacheType(cacheType: cacheType)
        apiModel.apiType = "\(key)_\(user?.msisdn ?? "")"
        user?.addToApimodel(apiModel)
        storage.saveContext()
    }
    
    private func getCurrentTime() -> String {
        let currentDate = Date()
        return currentDate.getStringFromDate(format: "dd-MM-yyyy HH:mm")
    }
    
    //MARK:- FETCH API MODEL RESPONSE
    @objc func fetchResponseFor(key: String, cacheType: CacheType) -> APIModelsEntity? {
        let user = store.fetchUserByCacheType(cacheType: cacheType)
        let allUsersPredicate = NSPredicate(format: "apiType == %@", "\(key)_\(user?.msisdn ?? "")")
        let specificUserPredicate = NSPredicate(format: "%K == %@", "user.msisdn", user?.msisdn ?? "")
        let compoundPredicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [allUsersPredicate, specificUserPredicate])
        return storage.fetchEntity(entity: .apiModel, for: compoundPredicate)?.first
    }
    
    //MARK:- DELETE API MODEL FOR CURRENT USER
    @objc func deleteAPIModelForCurrentUser() {
        let predicate = NSPredicate(format: "%K == %@", "user.msisdn", store.fetchCurrentUser()?.msisdn ?? "")
        storage.batchDeleteEntity(entity: .apiModel, for: predicate)
    }
    
    //MARK:- DELETE ALL API MODELS RESPONSE
    @objc func deleteAPIModels() {
        storage.batchDeleteEntity(entity: .apiModel)
    }
}
