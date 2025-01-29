//
//  ImageCache.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import Foundation
import UIKit

class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
        
    private init() {}
    
    func getImage(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
    
    func removeImage(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
}
