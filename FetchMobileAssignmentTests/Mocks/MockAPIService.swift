//
//  MockAPIService.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import Foundation
@testable import FetchMobileAssignment

class MockAPIService: APIServicing {
    static var shared: APIServicing { MockAPIService() }
    
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        if let error = mockError {
            throw error
        }
        
        return (mockData ?? Data(), mockResponse ?? URLResponse(url: url, mimeType: nil, expectedContentLength: 0, textEncodingName: nil))
    }
}
