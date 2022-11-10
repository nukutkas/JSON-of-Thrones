//
//  ImageView.swift
//  JSON of Thrones
//
//  Created by Татьяна Кочетова on 14.06.2021.
//

import UIKit

class ImageView: UIImageView {
    
    func fetchImage(from url: String) {
        guard let url = URL(string: url) else {
            image = #imageLiteral(resourceName: "Ivan")
            return
        }
        
        // Если изображение есть в кеше, то используем его
        if let cachedImage = getCachedImage(url: url) {
            image = cachedImage
            return
        }
        
        // Если изображения в кеше нет, то грузим его из сети
        ImageManager.shared.getImage(from: url) { (data, response) -> (Void) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            
            // Сохраняем изображение в кеш
            self.saveDataToCache(with: data, and: response)
        }
    }
    
    private func getCachedImage(url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
          return  UIImage(data: cachedResponse.data)
        }
        return nil
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let urlResponse = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let urlRequest = URLRequest(url: urlResponse)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
}
