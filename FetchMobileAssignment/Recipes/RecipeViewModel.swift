//
//  RecipeViewModel.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/26/25.
//


import Foundation
import Combine
import SwiftUICore

@MainActor
class RecipeViewModel: ObservableObject {
    var recipes: [Recipe] = []
    @Published var images: [String: Data] = [:]
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchText: String = ""
    
    let recipesProvider: RecipesProviding
    
    init(recipesProvider: RecipesProviding = RecipesProvider()) {
        self.recipesProvider = recipesProvider
    }
    
    var filteredRecipes: [Recipe] {
        guard (!searchText.isEmpty) else {
            return recipes
        }
        
        return recipes.filter {
            $0.name.lowercased().contains(searchText.lowercased()) ||
            $0.cuisine.lowercased().contains(searchText.lowercased())
        }
    }
    
    func getRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            recipes = try await recipesProvider.getRecipes()
            isLoading = false
        } catch {
            isLoading = false
            print(error.localizedDescription)
            errorMessage = "There was a problem getting the recipes. Please try again later."
            recipes = []
        }
    }
}
