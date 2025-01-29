//
//  RecipeRowViewModel.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//


import SwiftUI

@MainActor
class RecipeRowViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var validatedSmallPhotoURL: URL?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        validateURL()
    }
    
    private func validateURL() {
        if let smallPhotoURL = recipe.photoURLSmall {
            validatedSmallPhotoURL = URL(string: smallPhotoURL)
        }
    }
}