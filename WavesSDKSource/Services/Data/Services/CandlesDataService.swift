//
//  CandlesDataService.swift
//  Alamofire
//
//  Created by rprokofev on 06/05/2019.
//

import Foundation
import RxSwift
import Moya

public protocol CandlesDataServiceProtocol {
    
    func candles(query: DataService.Query.CandleFilters, enviroment: EnviromentService) -> Observable<DataService.DTO.Chart>
}

final class CandlesDataService: CandlesDataServiceProtocol {
    
    private let candlesProvider: MoyaProvider<DataService.Service.Candles>
    
    init(candlesProvider: MoyaProvider<DataService.Service.Candles>) {
        self.candlesProvider = candlesProvider
    }
    
    public func candles(query: DataService.Query.CandleFilters, enviroment: EnviromentService) -> Observable<DataService.DTO.Chart> {
        
        return self
            .candlesProvider
            .rx
            .request(.init(query: query,
                           dataUrl: enviroment.serverUrl),
                     callbackQueue: DispatchQueue.global(qos: .userInteractive))
            .filterSuccessfulStatusAndRedirectCodes()
            .catchError({ (error) -> Single<Response> in
                return Single<Response>.error(NetworkError.error(by: error))
            })
            .map(DataService.DTO.Chart.self)
            .asObservable()
    }
}