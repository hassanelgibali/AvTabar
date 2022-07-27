//
//  LoginValidation.swift
//  Ana Vodafone
//
//  Created by Ahmed Naser on 09/06/2021.
//  Copyright © 2021 Vodafone Egypt. All rights reserved.
//

import Foundation

//MARK:- KEYCLOAK VALIDATION
public struct KeyCloakValidation {
    
    //MARK:- IS VOICE
    func isVoiceLine(_ lineType: String?) -> Bool {
        lineType?.lowercased() == UserLineType.voice.rawValue.lowercased()
    }
}
