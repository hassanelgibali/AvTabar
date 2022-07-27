//
//  GenericHmacCalculation.swift
//  Ana Vodafone
//
//  Created by Yasmin Ahmed on 4/8/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import UIKit
import CommonCrypto

public enum CryptoAlgorithm {
    case MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    
    var HMACAlgorithm: CCHmacAlgorithm {
        var result: Int = 0
        switch self {
        case .MD5:      result = kCCHmacAlgMD5
        case .SHA1:     result = kCCHmacAlgSHA1
        case .SHA224:   result = kCCHmacAlgSHA224
        case .SHA256:   result = kCCHmacAlgSHA256
        case .SHA384:   result = kCCHmacAlgSHA384
        case .SHA512:   result = kCCHmacAlgSHA512
        }
        return CCHmacAlgorithm(result)
    }
    
    var digestLength: Int {
        var result: Int32 = 0
        switch self {
        case .MD5:      result = CC_MD5_DIGEST_LENGTH
        case .SHA1:     result = CC_SHA1_DIGEST_LENGTH
        case .SHA224:   result = CC_SHA224_DIGEST_LENGTH
        case .SHA256:   result = CC_SHA256_DIGEST_LENGTH
        case .SHA384:   result = CC_SHA384_DIGEST_LENGTH
        case .SHA512:   result = CC_SHA512_DIGEST_LENGTH
        }
        return Int(result)
    }
}

public class GenericHmacCalculation {
    public static func hmac(txt: String, algorithm: CryptoAlgorithm, secretKey: String) -> String {
        let str = txt.cString(using: String.Encoding.utf8)
        let strLen = Int(txt.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        let keyStr = secretKey.cString(using: String.Encoding.utf8)
        let keyLen = Int(secretKey.lengthOfBytes(using: String.Encoding.utf8))

        CCHmac(algorithm.HMACAlgorithm, keyStr!, keyLen, str!, strLen, result)

        let digest = stringFromResult(result: result, length: digestLen)

        result.deallocate()

        return digest
    }

    private static func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash).lowercased()
    }
    
    public static func hmacBase64(txt: String, algorithm: CryptoAlgorithm, secretKey: String) -> String {
        let inputData = txt.data(using: .utf8, allowLossyConversion: false)! as NSData
        let keyData = secretKey.data(using: .utf8, allowLossyConversion: false)! as NSData
        
        let digestLen = algorithm.digestLength
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: Int(digestLen))
        
        CCHmac(algorithm.HMACAlgorithm, keyData.bytes, keyData.count, inputData.bytes, inputData.count, result)
        let data = NSData(bytes: result, length: Int(digestLen))
        result.deallocate()
        return data.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
    }

    public static func sha256(_ data: Data) -> Data? {
        guard let res = NSMutableData(length: Int(CC_SHA256_DIGEST_LENGTH)) else { return nil }
        CC_SHA256((data as NSData).bytes, CC_LONG(data.count), res.mutableBytes.assumingMemoryBound(to: UInt8.self))
        return res as Data
    }

    public static func sha256(_ str: String) -> String? {
        guard
            let data = str.data(using: String.Encoding.utf8),
            let shaData = sha256(data)
        else { return nil }
        let rc = shaData.base64EncodedString(options: [])
        return rc
    }

}
