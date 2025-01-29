//
//  FetchMobileAssignmentTests.swift
//  FetchMobileAssignmentTests
//
//  Created by Laureano De Andrea on 1/24/25.
//

import XCTest
@testable import FetchMobileAssignment

class RecipeRemoteDataSourceTests: XCTestCase {

    var mockAPIService: MockAPIService!
    var recipeRemoteDataSource: RecipeRemoteDataSource!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        recipeRemoteDataSource = RecipeRemoteDataSource(apiService: mockAPIService)
    }

    func testGetRecipes_WithValidResponse_ReturnsRecipes() async throws {
        // Given
        let recipesResponse = RecipesResponse(recipes: [Recipe(id: "1", cuisine: "Mexican", name: "Tacos", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)])
        let data = try JSONEncoder().encode(recipesResponse)
        mockAPIService.mockData = data
        mockAPIService.mockResponse = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        // When
        let recipes = try await recipeRemoteDataSource.getRecipes()

        // Then
        XCTAssertNotNil(recipes)
        XCTAssertEqual(recipes.count, 1)
    }
    
    func testGetRecipes_WithValidResponseData_ReturnsRecipes() async throws {
        // Given
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "recipes", ofType: "json") else {
            XCTFail("JSON file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: []) else {
            XCTFail("Unable to read JSON file")
            return
        }
        
        mockAPIService.mockData = data
        mockAPIService.mockResponse = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        // When
        let recipes = try await recipeRemoteDataSource.getRecipes()

        // Then
        XCTAssertNotNil(recipes)
        XCTAssertEqual(recipes.count, 63)
    }
    
    func testGetRecipes_WithMalformedData_ThrowsError() async throws {
        // Given
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "malformedData", ofType: "json") else {
            XCTFail("JSON file not found")
            return
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath), options: []) else {
            XCTFail("Unable to read JSON file")
            return
        }
        
        mockAPIService.mockData = data
        mockAPIService.mockResponse = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        // When & Then
        do {
            _ = try await recipeRemoteDataSource.getRecipes()
            XCTFail("malformedData decoding should return an Error")
        } catch {
            XCTAssertNotNil(error as! DecodingError)
        }
    }

    func testGetRecipes_WithInvalidResponse_ThrowsError() async throws {
        // Given
        mockAPIService.mockData = Data()
        mockAPIService.mockResponse = URLResponse(url: URL(string: "https://example.com")!, mimeType: nil, expectedContentLength: 0, textEncodingName: nil)

        // When & Then
        do {
            _ = try await recipeRemoteDataSource.getRecipes()
            XCTFail("Se esperaba un error")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetRecipes_WithNetworkError_ThrowsError() async throws {
        // Given
        mockAPIService.mockError = NSError(domain: "NetworkError", code: 1, userInfo: nil)

        // When & Then
        do {
            _ = try await recipeRemoteDataSource.getRecipes()
            XCTFail("Se esperaba un error")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}



//// MARK: - RecipesRemoteDataSource Test Cases
//
//class RecipeRemoteDataSourceTests: XCTestCase {
//    var recipeRemoteDataSource: MockRecipeRemoteDataSource!
//    
//    override func setUp() {
//        super.setUp()
//        recipeRemoteDataSource = MockRecipeRemoteDataSource()
//    }
//    
//    override func tearDown() {
//        recipeRemoteDataSource = nil
//        super.tearDown()
//    }
//    
//    func testGetRecipes_WhenSuccessful_ReturnsRecipes() async throws {
//        // Given
//        let expectedRecipes = [
//            Recipe(
//                id: "1",
//                cuisine: "Italian",
//                name: "Pizza",
//                photoURLSmall: "small.jpg",
//                photoURLLarge: "large.jpg",
//                sourceURL: "source.com",
//                youtubeURL: "youtube.com"
//            )
//        ]
//
//        recipeRemoteDataSource.mockRecipes = expectedRecipes
//        
//        // When
//        let recipes = try await recipeRemoteDataSource.getRecipes()
//        
//        // Then
//        XCTAssertEqual(recipes, expectedRecipes)
//    }
//    
//    func testGetRecipes_WhenAPIFails_ThrowsError() async {
//        // Given
//        let expectedError = NSError(domain: "TestError", code: -1)
//        recipeRemoteDataSource.mockError = expectedError
//        
//        // When/Then
//        do {
//            _ = try await recipeRemoteDataSource.getRecipes()
//            XCTFail("Expected error to be thrown")
//        } catch {
//            XCTAssertEqual((error as NSError).domain, expectedError.domain)
//            XCTAssertEqual((error as NSError).code, expectedError.code)
//        }
//    }
//    
//}
//
//// MARK: -
//
//class RecipesProviderTests: XCTestCase {
//    var sut: RecipesProvider!
//    var mockRemoteDataSource: MockRecipeRemoteDataSource!
//    
//    override func setUp() {
//        super.setUp()
//        mockRemoteDataSource = MockRecipeRemoteDataSource()
//        sut = RecipesProvider(remoteDataSource: mockRemoteDataSource)
//    }
//    
//    override func tearDown() {
//        sut = nil
//        mockRemoteDataSource = nil
//        super.tearDown()
//    }
//    
//    func testGetRecipes_WhenSuccessful_ReturnsRecipes() async throws {
//        // Given
//        let expectedRecipes = [
//            Recipe(
//                id: "1",
//                cuisine: "Italian",
//                name: "Pizza",
//                photoURLSmall: "small.jpg",
//                photoURLLarge: "large.jpg",
//                sourceURL: "source.com",
//                youtubeURL: "youtube.com"
//            )
//        ]
//        mockRemoteDataSource.mockRecipes = expectedRecipes
//        
//        // When
//        let recipes = try await sut.getRecipes()
//        
//        // Then
//        XCTAssertEqual(recipes, expectedRecipes)
//    }
//    
//    func testGetRecipes_WhenRemoteDataSourceFails_ThrowsError() async {
//        // Given
//        let expectedError = NSError(domain: "TestError", code: -1)
//        mockRemoteDataSource.mockError = expectedError
//        
//        // When/Then
//        do {
//            _ = try await sut.getRecipes()
//            XCTFail("Expected error to be thrown")
//        } catch {
//            XCTAssertEqual((error as NSError).domain, expectedError.domain)
//            XCTAssertEqual((error as NSError).code, expectedError.code)
//        }
//    }
//}
//
//// MARK: - Recipe Model Tests
//class RecipeTests: XCTestCase {
//    func testRecipeDecoding_WhenValidJSON_DecodesSuccessfully() throws {
//        // Given
//        let json = """
//        {
//            "uuid": "123",
//            "cuisine": "Italian",
//            "name": "Pizza",
//            "photo_url_small": "small.jpg",
//            "photo_url_large": "large.jpg",
//            "source_url": "source.com",
//            "youtube_url": "youtube.com"
//        }
//        """.data(using: .utf8)!
//        
//        // When
//        let recipe = try JSONDecoder().decode(Recipe.self, from: json)
//        
//        // Then
//        XCTAssertEqual(recipe.id, "123")
//        XCTAssertEqual(recipe.cuisine, "Italian")
//        XCTAssertEqual(recipe.name, "Pizza")
//        XCTAssertEqual(recipe.photoURLSmall, "small.jpg")
//        XCTAssertEqual(recipe.photoURLLarge, "large.jpg")
//        XCTAssertEqual(recipe.sourceURL, "source.com")
//        XCTAssertEqual(recipe.youtubeURL, "youtube.com")
//    }
//    
//    func testRecipeDecoding_WhenOptionalFieldsAreNull_DecodesSuccessfully() throws {
//        // Given
//        let json = """
//        {
//            "uuid": "123",
//            "cuisine": "Italian",
//            "name": "Pizza",
//            "photo_url_small": null,
//            "photo_url_large": null,
//            "source_url": null,
//            "youtube_url": null
//        }
//        """.data(using: .utf8)!
//        
//        // When
//        let recipe = try JSONDecoder().decode(Recipe.self, from: json)
//        
//        // Then
//        XCTAssertEqual(recipe.id, "123")
//        XCTAssertEqual(recipe.cuisine, "Italian")
//        XCTAssertEqual(recipe.name, "Pizza")
//        XCTAssertNil(recipe.photoURLSmall)
//        XCTAssertNil(recipe.photoURLLarge)
//        XCTAssertNil(recipe.sourceURL)
//        XCTAssertNil(recipe.youtubeURL)
//    }
//}
