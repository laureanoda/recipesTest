//
//  RecipeDetailView.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import SwiftUICore
import SwiftUI

struct RecipeDetailView: View {
    @StateObject private var viewModel: RecipeDetailViewModel
    
    init(recipe: Recipe) {
        _viewModel = StateObject(wrappedValue: RecipeDetailViewModel(recipe: recipe))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Group {
                    if let photoURL = viewModel.validatedLargePhotoURL {
                        CustomAsyncImage(url: photoURL)
                    } else {
                        fallbackImage
                    }
                }
                .frame(height: 300)
                .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    // Title and Cuisine
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.recipe.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(viewModel.recipe.cuisine)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(Color.gray.opacity(0.2))
                            )
                    }
                    
                    // Links Section
                    VStack(spacing: 8) {
                        // YouTube Link
                        if let youtubeURL = viewModel.validatedYoutubeURL {
                            LinkButton(
                                url: youtubeURL,
                                icon: "play.circle.fill",
                                text: "Watch on YouTube",
                                iconColor: .red
                            )
                        }
                        
                        // Source Link
                        if let sourceURL = viewModel.validatedSourceURL {
                            LinkButton(
                                url: sourceURL,
                                icon: "link",
                                text: "View Recipe Source",
                                iconColor: .blue
                            )
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var fallbackImage: some View {
        Image(systemName: "photo")
            .font(.largeTitle)
            .foregroundColor(.gray)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.1))
    }
}

// Helper view for consistent link buttons
struct LinkButton: View {
    let url: URL
    let icon: String
    let text: String
    let iconColor: Color
    
    var body: some View {
        Link(destination: url) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                Text(text)
                Spacer()
                Image(systemName: "arrow.right")
                    .font(.caption)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe(
        id: "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
        cuisine: "British",
        name: "Apple Frangipan Tart",
        photoURLSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
        photoURLLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
        sourceURL: nil,
        youtubeURL: "https://www.youtube.com/watch?v=rp8Slv4INLk"
    ))
}
