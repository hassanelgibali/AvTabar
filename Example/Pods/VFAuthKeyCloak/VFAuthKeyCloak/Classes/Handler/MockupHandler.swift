//
//  MockupHandler.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/7/19.
//  Copyright © 2019 Vodafone Egypt. All rights reserved.
//

import Foundation
import ObjectMapper
class MockupHandler<T> where T:AVBaseModel {
    func getMockupModel(jsonFileName:String, completion:@escaping (T) -> ()){
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let model = Mapper<T>().map(JSONObject: jsonResult) {
                    completion(model)
                }
            } catch {
                // handle error
            }
        }
    }
    
    func getMockup(jsonFileName:String, completion:@escaping (Any) -> ()){
        print(jsonFileName)
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                completion(jsonResult)
            } catch {
                // handle error
            }
        }
    }
}
