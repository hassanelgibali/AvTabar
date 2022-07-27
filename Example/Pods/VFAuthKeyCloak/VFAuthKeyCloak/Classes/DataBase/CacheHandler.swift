//
//  CacheHandler.swift
//  Ana Vodafone
//
//  Created by Khaled mahmoud on 8/13/18.
//  Copyright © 2018 Vodafone Egypt. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper
import JSONModel

//MARK:- CACHE HANDLER
@objc public class CacheHandler: NSObject {
    
    //MARK:- PROPERTIES
    @objc public static let shared = CacheHandler()
    private static var storage: CoreDataStorage?
    private static var userInfoEntityStore: UserInfoEntityStoreProtocol?
    private static var apiModelsEntityStore: APIModelsEntityStore?
    private static var elasticEntityStore: ElasticEntityStore?
    private static var userFlagsEntityStore: UserFlagsEntityStore?
    
    //MARK:- INIT
    private override init() {}
    
    public class func configure(storage: CoreDataStorage = CoreDataManager.shared) {
        self.storage = storage
        self.userInfoEntityStore = UserInfoEntityStore(storage: storage, tokenInfoStore: TokenInfoKeyChainStore())
        if let userEntityStore = userInfoEntityStore {
            self.apiModelsEntityStore = APIModelsEntityStore(store: userEntityStore, storage: storage)
            self.elasticEntityStore = ElasticEntityStore(store: userEntityStore, storage: storage)
            self.userFlagsEntityStore = UserFlagsEntityStore(store: userEntityStore, storage: storage)
        }
    }
}

//MARK:- CACHE HANDLER + USER INFO STORE
extension CacheHandler {
    
    //MARK: SAVE NEW USER
    @objc public func saveCurrentUser(userInfoModel: UserInfoModel) {
        CacheHandler.userInfoEntityStore?.saveCurrentUser(userInfoModel: userInfoModel)
        UserInfo.shared.loadSavedUser()
    }
    
    //MARK: FETCH USERS
    @objc public func getAllUsers() -> [UserInfoEntity]? {
        CacheHandler.userInfoEntityStore?.fetchAllUsers()
    }
    
    @objc public func getCurrentUser() -> UserInfoEntity? {
        CacheHandler.userInfoEntityStore?.fetchCurrentUser()
    }
    
    @objc public func getUserByMsisdn(msisdn: String) -> UserInfoEntity? {
        CacheHandler.userInfoEntityStore?.fetchUserByMsisdn(msisdn: msisdn)
    }
    
    @objc public func getSavedUsers(with type: String) -> [UserInfoEntity]? {
        CacheHandler.userInfoEntityStore?.fetchSavedUsers(with: type)
    }
    
    //MARK: DELETE USER
    @objc public func deleteAllUsers() {
        CacheHandler.userInfoEntityStore?.deleteUserInfo(for: nil)
    }
    
    @objc public func deleteUser(msisdn: String) {
        CacheHandler.userInfoEntityStore?.deleteUserInfo(for: msisdn)
    }
    
    @objc public func deleteCachedEntitiesForCurrentUser() {
        CacheHandler.apiModelsEntityStore?.deleteAPIModelForCurrentUser()
        CacheHandler.userFlagsEntityStore?.deleteUserFlagsForCurrentUser()
        CacheHandler.elasticEntityStore?.deleteUserElasticModelForCurrentUser()
    }
    
    //MARK: UPDATE USER
    @objc public func updateUser(with properties: [String:Any], for msisdn: String){
        CacheHandler.userInfoEntityStore?.updateUser(with: properties, for: msisdn)
        UserInfo.shared.loadSavedUser()
    }
    
    @objc public func resetToken(msisdn: String) {
        CacheHandler.userInfoEntityStore?.resetCurrentUserToken(msisdn: msisdn)
    }
}

//MARK:- CACHE HANDLER + API MODELS STORE
extension CacheHandler {
    
    //MARK: SAVE API MODEL RESPONSE
    @objc public func save(JsonString: String, modelType: String) {
        CacheHandler.apiModelsEntityStore?.saveResponse(JsonString: JsonString, key: modelType, cacheType: .current)
    }
    
    @objc public func saveResponseGlobal(JsonString: String, modelType: String) {
        CacheHandler.apiModelsEntityStore?.saveResponse(JsonString: JsonString, key: modelType, cacheType: .global)
    }
    
    //MARK: FETCH API MODEL RESPONSE
    @objc public func getCurrentUserModel(modelType: String) -> APIModelsEntity? {
        return CacheHandler.apiModelsEntityStore?.fetchResponseFor(key: modelType, cacheType: .current)
    }
    
    @objc public func getGlobalModel(modelType: String) -> APIModelsEntity? {
        return CacheHandler.apiModelsEntityStore?.fetchResponseFor(key: modelType, cacheType: .global)
    }
    
    @objc public func getCurrentUserResponse(modelType: String) -> String? {
        return  getCurrentUserModel(modelType: modelType)?.jsonString
    }
}

//MARK:- CACHE HANDLER + ELASTIC STORE
extension CacheHandler {
    
    //MARK: SAVE ELASTIC MODEL
    @objc public func saveElasticData(encodedData: Data, isPayment: Bool) {
        CacheHandler.elasticEntityStore?.saveElasticData(encodedData: encodedData, isPayment: isPayment)
    }
    
    //MARK: FETCH ELASTIC MODEL
    @objc public func getSpecificElasticErrorsFor(msisdn: String, count: Int = 5) -> [ElasticEntity]? {
        return CacheHandler.elasticEntityStore?.fetchSpecificErrorsFor(msisdn: msisdn, count: count)
    }
    
    //MARK:- DELETE ELASTIC MODEL
    @objc public func deleteAllElasticModels() {
        CacheHandler.elasticEntityStore?.deleteAllElasticModels()
    }
}

//MARK:- CACHE HANDLER + USER FLAGS STORE
extension CacheHandler {
    
    //MARK: SAVE USER FLAGS
    @objc public func saveUserFlags(_ flagsModel: UserFlagsModel?) {
        guard let flagsModel = flagsModel else { return }
        CacheHandler.userFlagsEntityStore?.updateUserFlags(flags: flagsModel.toJSONString())
    }
    
    //MARK: FETCH USER FLAGS
    @objc public func getUserFlags() -> UserFlagsModel {
        let flags = CacheHandler.userFlagsEntityStore?.fetchUserFlags()?.flags
        var err: JSONModelError? = nil
        return UserFlagsModel(string: flags, error: &err) ?? UserFlagsModel()
    }
}
