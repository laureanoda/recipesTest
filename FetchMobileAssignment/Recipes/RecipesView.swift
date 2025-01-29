//
//  RecipesView.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/26/25.
//


import SwiftUI

struct RecipesView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.filteredRecipes) { recipe in
                NavigationLink {
                    RecipeDetailView(recipe: recipe)
                } label: {
                    RecipeRowView(recipe: recipe)
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Recipes")
            .toolbar {
                ProgressView("Loading...")
                    .opacity(viewModel.isLoading ? 1 : 0)
            }
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .task {
                await viewModel.getRecipes()
            }
            .refreshable {
                await viewModel.getRecipes()
            }
        }
    }
}

#Preview {
    let recipesViewModel = RecipeViewModel(recipesProvider: RecipesProvider(remoteDataSource: MockRecipeRemoteDataSource()))
    RecipesView(viewModel: recipesViewModel)
}
