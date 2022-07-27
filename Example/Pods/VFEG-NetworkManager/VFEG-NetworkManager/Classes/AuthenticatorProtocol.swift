//
//  AuthenticatorProtocol.swift
//  Ana Vodafone
//
//  Created by Ahmed Nasser on 7/14/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift

public protocol AuthenticatorProtocol {
    func getToken() -> Observable<Result<AuthModel?,NetworkError>>
}

public protocol AuthModel {
    var accessToken: String {get set}
    var expiresIn: Double {get set}
    var refreshToken: String? {get set}
    var refreshTokenExpiresIn: Double {get set}
    var seamlessToken: String? {get set}
}
