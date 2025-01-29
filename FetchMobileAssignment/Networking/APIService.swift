//
//  APIService.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/26/25.
//


import Foundation

protocol APIServicing {
    static var shared: APIServicing { get }
    func fetchData(from url: URL) async throws -> (Data, URLResponse)
}

class APIService: APIServicing {
    
    static var shared: APIServicing = APIService()
    
    public var urlSession: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 60
        config.allowsCellularAccess = true
        config.httpAdditionalHeaders = ["Accept": "application/json"]
        self.urlSession = URLSession(configuration: config)
    }
    
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return try await urlSession.data(for: request)
    }
}
