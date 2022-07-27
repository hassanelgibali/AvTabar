//
//  Cache.swift
//  LimozeinSwift
//
//  Created by Khaled Saad on 1/14/1439 AH.
//  Copyright © 1439 Khaled Saad. All rights reserved.
//
//This app has attempted to access privacy-sensitive data without a usage description. The app's Info.plist must contain an NSLocationWhenInUseUsageDescription key with a string value explaining to the user how the app uses this data
import UIKit

public class UserDefaultsHandler: NSObject {
    
    private static func archiveUserInfo(info: Any) -> NSData {
        
        return NSKeyedArchiver.archivedData(withRootObject: info) as NSData
    }
    
    public class func object(key: String) -> Any? {
        
        if let unarchivedObject = UserDefaults.standard.object(forKey: key) as? Data {
            
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data)
        }
        
        return nil
    }
    
    public class func set(object: Any? ,forKey key:String) {
        
        let archivedObject = archiveUserInfo(info: object!)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    public class func removeObject(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
