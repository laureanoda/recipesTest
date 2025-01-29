//
//  AsyncImage.swift
//  FetchMobileAssignment
//
//  Created by Laureano De Andrea on 1/28/25.
//

import SwiftUI

struct CustomAsyncImage: View {
    @StateObject var imageLoader: ImageLoader
    
    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        VStack {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await imageLoader.load()
            }
        }
    }
}
