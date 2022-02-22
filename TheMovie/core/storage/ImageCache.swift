//
//  ImageCache.swift
//  TheMovie
//
//  Created by Monika Mateska on 22.2.22.
//

import UIKit
import Foundation

public class ImageCache {
    
    public static let publicCache = ImageCache()
    var placeholderImage = UIImage(named: "placeholder")!
    
    private let cachedImages = NSCache<NSURL, UIImage>()
    
    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }
    
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        Task {
            do {
                let loadedImage = try await APIService.shared.fetchImage(url: url as URL)
                DispatchQueue.main.async {
                    completion(loadedImage)
                }
                self.cachedImages.setObject(loadedImage, forKey: url, cost: loadedImage.pngData()!.count)
            } catch {
                print("Failed to load an image from the server")
                completion(nil)
            }
        }
        
    }
}
