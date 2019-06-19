//
//  Enviroment.swift
//  Alamofire
//
//  Created by rprokofev on 28/05/2019.
//

import Foundation

public struct Enviroment {
    
    public enum Server {
        case mainNet
        case testNet
        case custom(node: URL, matcher: URL, data: URL, scheme: String)
    }
    
    public var server: Server {
        
        didSet {
            switch server {
            case .custom(let node, let matcher, let data, let scheme):
                self.scheme = scheme
                self.dataUrl = data
                self.nodeUrl = node
                self.matcherUrl = matcher
                
            case .mainNet:
                self.scheme = "W"
                self.dataUrl = URL(string: "https://api.wavesplatform.com")!
                self.nodeUrl = URL(string: "https://nodes.wavesnodes.com")!
                self.matcherUrl = URL(string: "https://matcher.wavesplatform.com")!
                
            case .testNet:
                self.scheme = "T"
                self.dataUrl = URL(string: "https://api.testnet.wavesplatform.com")!
                self.nodeUrl = URL(string: "https://pool.testnet.wavesnodes.com")!
                self.matcherUrl = URL(string: "https://matcher.testnet.wavesnodes.com")!
            }
        }
    }
    
    public var timestampServerDiff: Int64
    public var scheme: String!
    
    public var nodeUrl: URL
    public var matcherUrl: URL
    public var dataUrl: URL
    
    public init(server: Server, timestampServerDiff: Int64) {
        
        self.server = server
        self.timestampServerDiff = timestampServerDiff
        
        switch server {
        case .custom(let node, let matcher, let data, let scheme):
            self.scheme = scheme
            self.dataUrl = data
            self.nodeUrl = node
            self.matcherUrl = matcher
            
        case .mainNet:
            self.scheme = "W"
            self.dataUrl = URL(string: "https://api.wavesplatform.com")!
            self.nodeUrl = URL(string: "https://nodes.wavesnodes.com")!
            self.matcherUrl = URL(string: "https://matcher.wavesplatform.com")!
            
        case .testNet:
            self.scheme = "T"
            self.dataUrl = URL(string: "https://api.testnet.wavesplatform.com")!
            self.nodeUrl = URL(string: "https://pool.testnet.wavesnodes.com")!
            self.matcherUrl = URL(string: "https://matcher.testnet.wavesnodes.com")!
        }
    }
}