//
//  ImageLoader.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    let url: URL
    private let apiService: APIServicing
    
    init(url: URL, apiService: APIServicing = APIService.shared) {
        self.url = url
        self.apiService = apiService
    }
    
    func load() async {
        // Check cache first
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) {
            await MainActor.run {
                self.image = cachedImage
            }
            return
        }
        
        // Load image from URL
        do {
            let (data, _) = try await apiService.fetchData(from: url)
            if let image = UIImage(data: data) {
                await cacheImage(image)
                await MainActor.run {
                    self.image = image
                }
            }
        } catch {
            await MainActor.run {
                self.image = nil
            }
            print("Error loading image: \(error)")
        }
    }
    
    func cacheImage(_ image: UIImage) async {
        await MainActor.run {
            ImageCache.shared.setImage(image, forKey: self.url.absoluteString)
        }
    }
}
