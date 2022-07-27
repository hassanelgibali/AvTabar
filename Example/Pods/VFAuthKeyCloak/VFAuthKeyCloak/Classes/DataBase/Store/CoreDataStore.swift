//
//  CoreDataStore.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 07/04/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- CORE DATA STORE
public protocol CoreDataStore {
    var storage: CoreDataStorage { get set }
}

//MARK:- USER CACHE TYPE
@objc public enum CacheType: Int {
    case current
    case global
}
