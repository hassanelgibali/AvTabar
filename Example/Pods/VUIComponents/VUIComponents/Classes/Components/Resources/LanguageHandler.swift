//
//  LanguageHandler.swift
//  VUIComponents
//
//  Created by Mahmoud Tarek on 12/07/2021.
//  Copyright © 2021 Ahmed Nasser. All rights reserved.
//

import Foundation
import MOLH

@objc public enum Language: Int {
    case english
    case arabic
    case unknown
}

@objc public class LanguageHandler: NSObject {

    @objc public static let sharedInstance = LanguageHandler()
    
    @objc public func string(forKey key: String?) -> String {
        return NSLocalizedString(key ?? "", comment: "")
    }
    
    @objc public func setLanguage(_ language: Language) {
        MOLH.setLanguageTo(language == .arabic ? "ar" : "en")
        MOLH.reset(transition: .curveEaseInOut)
    }
    
    @objc public func currentLanguage() -> Language {
        let appleLang = MOLHLanguage.currentAppleLanguage()
        switch appleLang {
        case "ar":
            return .arabic
        case "en":
            return .english
        default:
            return .unknown
        }
    }
}
