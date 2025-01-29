//
//  RecipeRowView.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import SwiftUI

public struct RecipeRowView: View {
    @StateObject private var viewModel: RecipeRowViewModel
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeRowViewModel(recipe: recipe))
    }
    
    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Image with fallback
            Group {
                if let imageURL = viewModel.validatedSmallPhotoURL {
                    CustomAsyncImage(url: imageURL)
                } else {
                    fallbackImage
                }
            }
            .frame(width: 60, height: 60)
            .cornerRadius(5)
            
            // Text content
            VStack(alignment: .leading, spacing: 4) {
                Text(viewModel.recipe.name)
                    .font(.headline)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(viewModel.recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer(minLength: 0)
        }
        .frame(maxHeight: 60)
    }
    
    private var fallbackImage: some View {
        Image(systemName: "photo")
            .font(.title2)
            .foregroundColor(.gray)
            .frame(width: 60, height: 60)
            .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    var recipe = Recipe(
        id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
        cuisine: "British",
        name: "Apple Frangipan Tart",
        photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
        photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/larg.jpg",
        sourceURL: nil,
        youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk"
    )
    RecipeRowView(recipe: recipe)
        .padding()
    let recipeWithoutImage = Recipe(
        id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
        cuisine: "British",
        name: "Apple Frangipan Tart",
        photoURLSmall: nil,
        photoURLLarge: nil,
        sourceURL: nil,
        youtubeURL: nil
    )
    RecipeRowView(recipe: recipeWithoutImage)
        .padding()
    let recipeWithLongTexts = Recipe(
        id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
        cuisine: "British, French, Italian, American, Japanese, Chinese, Indian",
        name: "Apple Frangipan Tart, Apple Frangipan Tart, Apple Frangipan Tart, Apple Frangipan Tart",
        photoURLSmall: nil,
        photoURLLarge: nil,
        sourceURL: nil,
        youtubeURL: nil
    )
    RecipeRowView(recipe: recipeWithLongTexts)
        .padding()
}
