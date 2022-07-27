//
//  UserInfoEntityStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 8/26/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import CoreData

//MARK:- USER INFO STORE PROTOCOL
@objc public  protocol UserInfoEntityStoreProtocol {
    
    @objc func saveCurrentUser(userInfoModel: UserInfoModel)
    @objc func fetchAllUsers() -> [UserInfoEntity]?
    @objc func fetchCurrentUser() -> UserInfoEntity?
    @objc func fetchUserByMsisdn(msisdn: String) -> UserInfoEntity?
    @objc func fetchUserByCacheType(cacheType: CacheType) -> UserInfoEntity?
    @objc func fetchGlobalUser() -> UserInfoEntity
    @objc func fetchSavedUsers(with type: String) -> [UserInfoEntity]?
    @objc func deleteUserInfo(for msisdn: String?)
    @objc func updateUser(with properties: [String:Any], for msisdn: String)
    @objc func resetCurrentUserToken(msisdn: String)
}

//MARK:- USER INFO STORE
@objc public class UserInfoEntityStore: NSObject, UserInfoEntityStoreProtocol {
    
    //MARK:- PROPERTIES & INIT
    private let storage: CoreDataStorage
    private var tokenInfoStore: TokenInfoKeyChainStore
    
    init(storage: CoreDataStorage, tokenInfoStore: TokenInfoKeyChainStore) {
        self.storage = storage
        self.tokenInfoStore = tokenInfoStore
    }
}

//MARK:- SAVE NEW USER
extension UserInfoEntityStore {
    
    @objc public func saveCurrentUser(userInfoModel: UserInfoModel) {
        resetCurrentUserFlag()
        addNewCurrentUser(userInfoModel: userInfoModel)
    }
    
    //set current user (false and save change before set new one)
    private func resetCurrentUserFlag() {
        if let currentUser = fetchCurrentUser() {
            currentUser.isCurrentUser = false
            storage.saveContext()
        }
    }
    
    private func addNewCurrentUser(userInfoModel: UserInfoModel) {
        _ = UserEntityMapper.mapUserInfoModel(userInfo: userInfoModel, context: storage.privateContext)
        storage.saveContext()
    }
}

//MARK:- FETCH USERS
extension UserInfoEntityStore {
    
    @objc public func fetchAllUsers() -> [UserInfoEntity]? {
        let globalUserPredicate = NSPredicate(format: "msisdn != %@", CachingConstants.GLOBAL_USER_CONSTANT)
        return storage.fetchEntity(entity: .userInfo, for: globalUserPredicate)
    }
    
    @objc public func fetchCurrentUser() -> UserInfoEntity? {
        let currentUserPredicate = NSPredicate(format: "isCurrentUser == true")
        return storage.fetchEntity(entity: .userInfo, for: currentUserPredicate)?.first
    }
    
    @objc public func fetchUserByMsisdn(msisdn: String) -> UserInfoEntity? {
        let userPredicate = NSPredicate(format: "msisdn == %@", msisdn)
        return storage.fetchEntity(entity: .userInfo, for: userPredicate)?.first
    }
    
    @objc public func fetchUserByCacheType(cacheType: CacheType) -> UserInfoEntity? {
        return cacheType == .current ? fetchCurrentUser() : fetchGlobalUser()
    }
    
    @objc public func fetchGlobalUser() -> UserInfoEntity {
        let globalUserPredicate = NSPredicate(format: "msisdn == %@", CachingConstants.GLOBAL_USER_CONSTANT)
        guard let globalUser: UserInfoEntity = storage.fetchEntity(entity: .userInfo, for: globalUserPredicate)?.first else {
            let userEntity = UserInfoEntity(context: storage.privateContext)
            userEntity.msisdn = CachingConstants.GLOBAL_USER_CONSTANT
            storage.saveContext()
            return userEntity
        }
        return globalUser
    }
    
    @objc public func fetchSavedUsers(with type: String) -> [UserInfoEntity]? {
        let usersPredicate = NSPredicate(format: "loginType == %@", type)
        return storage.fetchEntity(entity: .userInfo, for: usersPredicate)
    }
}

//MARK:- DELETE USER
extension UserInfoEntityStore {
    
    @objc public func deleteUserInfo(for msisdn: String?) {
        var userPredicate: NSPredicate?
        if let userMsisdn = msisdn {
            userPredicate = NSPredicate(format: "msisdn == %@", userMsisdn)
        }
        storage.batchDeleteEntity(entity: .userInfo, for: userPredicate)
        try? tokenInfoStore.resetUserToken(msisdn: msisdn ?? "")
    }
}

//MARK:- UPDATE USER
extension UserInfoEntityStore {
    
    @objc public func updateUser(with properties: [String:Any], for msisdn: String) {
        let userPredicate = NSPredicate(format: "msisdn == %@", msisdn)
        storage.batchUpdateEntity(entity: .userInfo, propertiesToUpdate: properties, for: userPredicate)
    }
}

//MARK:- USER + TOKEN
extension UserInfoEntityStore {
    
    @objc public func resetCurrentUserToken(msisdn: String) {
        try? tokenInfoStore.resetUserToken(msisdn: msisdn)
    }
}
