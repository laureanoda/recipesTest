//
//  ImageLoaderTests.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//


import XCTest
@testable import FetchMobileAssignment

class ImageLoaderTests: XCTestCase {

    var imageLoader: ImageLoader!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        imageLoader = ImageLoader(url: URL(string: "https://example.com/image.jpg")!, apiService: mockAPIService)
    }
    
    func testImageLoader_InitialImage_IsNil() {
        XCTAssertNil(imageLoader.image)
    }
    
    func testImageLoader_LoadImage_FromCache() async {
        // Given
        let cachedImage = UIImage()
        ImageCache.shared.setImage(cachedImage, forKey: imageLoader.url.absoluteString)
        
        // When
        await imageLoader.load()
        
        // Then
        XCTAssertEqual(imageLoader.image, cachedImage)
    }
    
    func testImageLoader_LoadImage_FromURL() async {
        // Given
        let imageData = Data()
        mockAPIService.mockData = imageData
        
        // When
        await imageLoader.load()
        
        // Then
        XCTAssertNotNil(imageLoader.image)
    }
    
    func testImageLoader_LoadImage_FromURL_Fails() async {
        // Given
        mockAPIService.mockError = NSError(domain: "TestError", code: 1, userInfo: nil)
        
        // When
        await imageLoader.load()
        
        // Then
        XCTAssertNil(imageLoader.image)
    }
    
    func testImageLoader_CacheImage() async {
        // Given
        let image = UIImage()
        
        // When
        await imageLoader.cacheImage(image)
        
        // Then
        XCTAssertEqual(ImageCache.shared.getImage(forKey: imageLoader.url.absoluteString), image)
    }
}
