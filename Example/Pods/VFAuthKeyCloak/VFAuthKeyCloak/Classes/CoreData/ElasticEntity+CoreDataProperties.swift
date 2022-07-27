//
//  ElasticEntity+CoreDataProperties.swift
//  VFAuthKeyCloak
//
//  Created by Khaled Mahmoud Saad on 09/11/2021.
//
//

import Foundation
import CoreData


extension ElasticEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ElasticEntity> {
        return NSFetchRequest<ElasticEntity>(entityName: "ElasticEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var encodedData: Data?
    @NSManaged public var isPayment: Bool
    @NSManaged public var user: UserInfoEntity?

}
