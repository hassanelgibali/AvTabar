//
//  ElasticEntity+Extension.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 6/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import CoreData

//MARK:- ELASTIC STORE EXTENSION
extension ElasticEntity {
    
    //MARK:- COPY MODEL
    public func copy(context: NSManagedObjectContext) -> ElasticEntity? {
        let attributes = entity.attributesByName.map { $0.key }
        let dictionary = dictionaryWithValues(forKeys: attributes)
        let elasticCopy = NSEntityDescription.insertNewObject(forEntityName: "ElasticEntity", into: context) as? ElasticEntity
        elasticCopy?.setValuesForKeys(dictionary)
        return elasticCopy
    }
}
