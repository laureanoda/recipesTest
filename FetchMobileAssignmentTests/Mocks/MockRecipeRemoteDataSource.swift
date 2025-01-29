//
//  MockRecipeRemoteDataSource.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

@testable import FetchMobileAssignment

class MockRecipeRemoteDataSource: RecipeRemoteDataSourceProtocol {
    var mockRecipes: [Recipe]?
    var mockError: Error?
    
    func getRecipes() async throws -> [Recipe] {
        if let error = mockError {
            throw error
        }
        return mockRecipes ?? []
    }
}
