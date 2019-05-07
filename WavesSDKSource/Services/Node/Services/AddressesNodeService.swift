//
//  AddressesNodeTarget.swift
//  Alamofire
//
//  Created by rprokofev on 30/04/2019.
//

import Foundation
import RxSwift
import Moya

public protocol AddressesNodeServiceProtocol {
    
    func accountBalance(address: String, enviroment: EnviromentService) -> Observable<Node.DTO.AccountBalance>
    
    func scriptInfo(address: String, enviroment: EnviromentService) -> Observable<Node.DTO.AddressScriptInfo>
}

final class AddressesNodeService: AddressesNodeServiceProtocol {
    
    private let addressesProvider: MoyaProvider<Node.Service.Addresses>
    
    init(addressesProvider: MoyaProvider<Node.Service.Addresses>) {
        self.addressesProvider = addressesProvider
    }
    
    public func accountBalance(address: String, enviroment: EnviromentService) -> Observable<Node.DTO.AccountBalance> {
        
        return self
            .addressesProvider
            .rx
            .request(.init(kind: .getAccountBalance(id: address),
                           nodeUrl: enviroment.serverUrl),
                     callbackQueue: DispatchQueue.global(qos: .userInteractive))
            .filterSuccessfulStatusAndRedirectCodes()
            .catchError({ (error) -> Single<Response> in
                return Single.error(NetworkError.error(by: error))
            })
            .map(Node.DTO.AccountBalance.self)
            .asObservable()
    }
    
    public func scriptInfo(address: String, enviroment: EnviromentService) -> Observable<Node.DTO.AddressScriptInfo> {
        return self
            .addressesProvider
            .rx
            .request(.init(kind: .scriptInfo(id: address),
                           nodeUrl: enviroment.serverUrl),
                     callbackQueue: DispatchQueue.global(qos: .userInteractive))
            .filterSuccessfulStatusAndRedirectCodes()
            .catchError({ (error) -> Single<Response> in
                return Single.error(NetworkError.error(by: error))
            })
            .map(Node.DTO.AddressScriptInfo.self)
            .asObservable()
    }
}