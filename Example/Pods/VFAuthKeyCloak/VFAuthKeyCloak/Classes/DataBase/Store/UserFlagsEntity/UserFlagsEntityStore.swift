//
//  UserFlagsEntityStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 06/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- USER FLAGS STORE
@objc public class UserFlagsEntityStore: NSObject, CoreDataStore {
    
    //MARK:- PROPERTIES & INIT
    public var storage: CoreDataStorage
    var store: UserInfoEntityStoreProtocol
    
    public init(store: UserInfoEntityStoreProtocol, storage: CoreDataStorage) {
        self.store = store
        self.storage = storage
    }
    
    //MARK:- SAVE USER FLAGS
    @objc public func updateUserFlags(flags: String) {
        let userFlags = UserFlagsEntity(context: storage.privateContext)
        userFlags.flags = flags
        let user = store.fetchCurrentUser()
        userFlags.msisdn = user?.msisdn
        user?.addToFlags(userFlags)
        storage.saveContext()
    }
    
    //MARK:- FETCH USER FLAGS
    @objc public func fetchUserFlags() -> UserFlagsEntity? {
        let predicate = NSPredicate(format: "%K == %@", "msisdn", store.fetchCurrentUser()?.msisdn ?? "")
        let models = storage.fetchEntity(entity: .flags, for: predicate) as? [UserFlagsEntity]
        return  models?.first
    }
    
    //MARK:- DELETE USER FLAGS FOR CURRENT USER
    @objc public func deleteUserFlagsForCurrentUser() {
        let predicate = NSPredicate(format: "%K == %@", "msisdn", store.fetchCurrentUser()?.msisdn ?? "")
        storage.batchDeleteEntity(entity: .flags, for: predicate)
    }
}
