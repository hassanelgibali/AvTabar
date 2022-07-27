//
//  APIModelsEntity+CoreDataProperties.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 09/11/2021.
//
//

import Foundation
import CoreData


extension APIModelsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<APIModelsEntity> {
        return NSFetchRequest<APIModelsEntity>(entityName: "APIModelsEntity")
    }

    @NSManaged public var apiType: String?
    @NSManaged public var jsonString: String?
    @NSManaged public var time: String?
    @NSManaged public var user: UserInfoEntity?

}
