//
//  RecipeDetailViewModel.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import Combine
import Foundation

@MainActor
class RecipeDetailViewModel: ObservableObject {
    @Published var recipe: Recipe
    @Published var validatedLargePhotoURL: URL?
    @Published var validatedSmallPhotoURL: URL?
    @Published var validatedSourceURL: URL?
    @Published var validatedYoutubeURL: URL?
    
    init(recipe: Recipe) {
        self.recipe = recipe
        validateURLs()
    }
    
    private func validateURLs() {
        // Validate large photo URL
        if let photoURLLarge = recipe.photoURLLarge {
            validatedLargePhotoURL = URL(string: photoURLLarge)
        }
        
        // Validate small photo URL
        if let smallPhotoURL = recipe.photoURLSmall {
            validatedSmallPhotoURL = URL(string: smallPhotoURL)
        }
        
        // Validate source URL if present
        if let sourceURLString = recipe.sourceURL {
            validatedSourceURL = URL(string: sourceURLString)
        }
        
        // Validate YouTube URL
        if let youtubeURL = recipe.youtubeURL {
            validatedYoutubeURL = URL(string: youtubeURL)
        }
    }
}
