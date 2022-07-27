//
//  UserFlagsEntity+CoreDataProperties.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 09/11/2021.
//
//

import Foundation
import CoreData


extension UserFlagsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserFlagsEntity> {
        return NSFetchRequest<UserFlagsEntity>(entityName: "UserFlagsEntity")
    }

    @NSManaged public var flags: String?
    @NSManaged public var msisdn: String?
    @NSManaged public var user: UserInfoEntity?

}
