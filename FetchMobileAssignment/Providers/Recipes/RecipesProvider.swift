//
//  RecipeUseCase.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/26/25.
//


import Foundation

protocol RecipesProviding {
    func getRecipes() async throws -> [Recipe]
}

class RecipesProvider: RecipesProviding {
    let remoteDataSource: RecipeRemoteDataSourceProtocol
    
    init(remoteDataSource: RecipeRemoteDataSourceProtocol = RecipeRemoteDataSource()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getRecipes() async throws -> [Recipe] {
        try await remoteDataSource.getRecipes()
    }
}
