//
//  RecipeRemoteDataSource.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/26/25.
//


import Foundation

protocol RecipeRemoteDataSourceProtocol {
    func getRecipes() async throws -> [Recipe]
}

class RecipeRemoteDataSource: RecipeRemoteDataSourceProtocol {
    let apiService: APIServicing
    
    init(apiService: APIServicing = APIService.shared) {
        self.apiService = apiService
    }
    
    func getRecipes() async throws -> [Recipe] {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        let (data, _) = try await apiService.fetchData(from: url)
        let response = try JSONDecoder().decode(RecipesResponse.self, from: data)
        return response.recipes
    }
}

class MockRecipeRemoteDataSource: RecipeRemoteDataSourceProtocol {
    func getRecipes() async throws -> [Recipe] {
        return [
            Recipe(
                id: "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                cuisine: "Malaysian",
                name: "Apam Balik LONG LONG LONG LONG NAME",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                sourceURL: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                youtubeURL: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            ),
            Recipe(
                id: "599344f4-3c5c-4cca-b914-2210e3b3312f",
                cuisine: "British",
                name: "Apple & Blackberry Crumble",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                sourceURL: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                youtubeURL: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            ),
            Recipe(
                id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                cuisine: "British",
                name: "Apple Frangipan Tart",
                photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                sourceURL: nil,
                youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk"
            )
        ]
    }
}
