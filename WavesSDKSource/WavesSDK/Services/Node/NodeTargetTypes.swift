//
//  NodeTargetType.swift
//  WavesWallet-iOS
//
//  Created by mefilt on 09.07.2018.
//  Copyright © 2018 Waves Platform. All rights reserved.
//

import Foundation
import Result
import Moya

public enum NodeService {}

public extension NodeService {
    public enum DTO {}
    public enum Query {}
    internal enum Target {}
}

protocol NodeTargetType: TargetType {
    var nodeUrl: URL { get }
}

extension NodeTargetType {
    
    var baseURL: URL { return nodeUrl }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return ContentType.applicationJson.headers
    }
}