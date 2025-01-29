//
//  RecipeViewModelTests.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//


import XCTest
@testable import FetchMobileAssignment

class RecipeViewModelTests: XCTestCase {

    var viewModel: RecipeViewModel!
    var mockRecipesProvider: MockRecipesProvider!

    override func setUp() async throws {
        let _ = await MainActor.run {
            self.mockRecipesProvider = MockRecipesProvider()
            self.viewModel = RecipeViewModel(recipesProvider: mockRecipesProvider)
        }
    }

    func testInit_WithDefaultProvider_SetsProvider() async {
        // Given we inititalized the viewModel

        // Then
        let _ = await MainActor.run {
            XCTAssertNotNil(viewModel.recipesProvider)
        }
    }

    func testGetRecipes_WithValidData_SetsRecipes() async {
        // Given
        let recipes = [Recipe(id: "1", cuisine: "Mexican", name: "Tacos", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)]
        mockRecipesProvider.mockRecipes = recipes

        
        let _ = await MainActor.run {
            Task {
                // When
                await viewModel.getRecipes()
                // Then
                XCTAssertNotNil(viewModel.recipes)
                XCTAssertEqual(viewModel.recipes, recipes)
            }
        }
    }

    func testGetRecipes_WithNetworkError_SetsErrorMessage_AndResetsRecipes() async {
        // Given
        mockRecipesProvider.mockError = NSError(domain: "NetworkError", code: 1, userInfo: nil)

        let _ = await MainActor.run {
            Task {
                // Given we start with a previous result
                viewModel.recipes = [Recipe(id: "", cuisine: "", name: "", photoURLSmall: "", photoURLLarge: "", sourceURL: "", youtubeURL: "")]
                
                // When
                
                await viewModel.getRecipes()
                // Then
                XCTAssertNotNil(viewModel.errorMessage)
                XCTAssertEqual(viewModel.recipes, [])
            }
        }
    }
    
    func testFilteredRecipes_WithEmptySearchText_ReturnsAllRecipes() async {
        let _ = await MainActor.run {
            Task {
                // Given
                viewModel.recipes = [Recipe(id: "", cuisine: "", name: "", photoURLSmall: "", photoURLLarge: "", sourceURL: "", youtubeURL: "")]
                
                // When
                let filteredRecipes = viewModel.filteredRecipes
                
                // Then
                XCTAssertEqual(filteredRecipes, viewModel.recipes)
            }
        }
    }
    
    func testFilteredRecipes_WithSearchText_ReturnsFilteredRecipes() async {
        let _ = await MainActor.run {
            Task {
                // Given
                let matchingRecipe = Recipe(id: "", cuisine: "Uruguayan", name: "", photoURLSmall: "", photoURLLarge: "", sourceURL: "", youtubeURL: "")
                viewModel.recipes = [Recipe(id: "", cuisine: "Mexican", name: "", photoURLSmall: "", photoURLLarge: "", sourceURL: "", youtubeURL: ""),
                                     Recipe(id: "", cuisine: "", name: "Mexican", photoURLSmall: "", photoURLLarge: "", sourceURL: "", youtubeURL: ""),
                                     matchingRecipe]
                
                // When
                viewModel.searchText = "Uruguayan"
            
                // Then
                XCTAssertEqual(viewModel.filteredRecipes, [matchingRecipe])
            }
        }
    }
}
