//
//  CertificatePinner.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 6/29/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import TrustKit

public class CertificatePinner {
   public class func pinCertificates() {
        let trustKitConfig = [
            kTSKEnforcePinning: true,
            kTSKIncludeSubdomains: true,
            kTSKSwizzleNetworkDelegates: false,
            kTSKPinnedDomains: [
                "mobile.vodafone.com.eg": [
                    kTSKPublicKeyHashes: [
                        "yMoKrrKMydah5ZHYUtRtI5IJtR+5hZ1Ls7rO8jHsLjU=",
                        "BmgFollTF4Xl1xggrcX/T6H880dizBRToDg9dZcJibw=",
                        "wdks7OHYA8F/OIfcK4rPxn5H2QjOLZN2paEk/D+64W8="
                    ],
                ]
            ]
            ] as [String : Any]
        TrustKit.initSharedInstance(withConfiguration:trustKitConfig)
    }
}
