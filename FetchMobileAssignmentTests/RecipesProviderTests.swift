//
//  RecipesProviderTests.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//
import XCTest
@testable import FetchMobileAssignment

class RecipesProviderTests: XCTestCase {

    var mockRemoteDataSource: MockRecipeRemoteDataSource!
    var recipesProvider: RecipesProvider!

    override func setUp() {
        super.setUp()
        mockRemoteDataSource = MockRecipeRemoteDataSource()
        recipesProvider = RecipesProvider(remoteDataSource: mockRemoteDataSource)
    }

    func testGetRecipes_WithValidData_ReturnsRecipes() async throws {
        // Arrange
        let recipes = [Recipe(id: "1", cuisine: "Mexican", name: "Tacos", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)]
        mockRemoteDataSource.mockRecipes = recipes

        // Act
        let result = try await recipesProvider.getRecipes()

        // Assert
        XCTAssertNotNil(result)
        XCTAssertEqual(result, recipes)
    }

    func testGetRecipes_WithNetworkError_ThrowsError() async throws {
        // Arrange
        mockRemoteDataSource.mockError = NSError(domain: "NetworkError", code: 1, userInfo: nil)

        // Act y Assert
        do {
            _ = try await recipesProvider.getRecipes()
            XCTFail("Expected a NetworkError")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
