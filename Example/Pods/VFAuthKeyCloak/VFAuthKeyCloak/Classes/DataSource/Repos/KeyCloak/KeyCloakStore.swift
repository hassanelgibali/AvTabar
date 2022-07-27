//
//  KeyCloakStore.swift
//  Ana Vodafone
//
//  Created by Mahmoud Tarek on 9/6/20.
//  Copyright © 2020 Vodafone Egypt. All rights reserved.
//

import Foundation
import RxSwift
import VFEG_NetworkManager
import ObjectMapper

//MARK:- KEYCLOAK STORE
class KeyCloakStore: BaseDXLRxStore<DXLAuthModel> {
    
    //MARK:- GET KEYCLOAK TOKEN
    func getKeyCloakToken(router: KeyCloakRouter) -> Observable<AvRxResult<T?>> {
        let request = router.method == .post ? DxlApiRouter.post(router) : DxlApiRouter.get(router)
        let builder = DXLNetworkBuilder(request: request)
        let observer = DXLNetworkManager.shared.request(builder: builder).map {
            self.parsingResponse($0)
        }
        return filterObservable(observable: observer)
    }
    
    //MARK:- PARSING KEYCLOAK MODEL
    private func parsingResponse(_ response: NetworkResponse) -> AvRxResult<DXLAuthModel?> {
        switch response {
        case .networkSuccess(let json,_,_):
            return NetworkParser.object(type: DXLAuthModel.self, response: json)
        case .networkFaliure(let error):
            return .failure(NetworkErrorMapper.map(networkError: error))
        }
    }
}
