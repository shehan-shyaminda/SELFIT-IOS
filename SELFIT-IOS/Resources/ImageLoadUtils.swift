//
//  ImageLoadUtils.swift
//  SELFIT-IOS
//
//  Created by Dinuka Shehan on 2023-05-22.
//

import Foundation
import UIKit

func loadImage(from url: URL, into imageView: UIImageView) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print("Error downloading image: \(error)")
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let imageData = data {
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    imageView.image = adjustImageOpacity(image: image, opacity: 0.8)
                    
                }
            } else {
                print("Unable to create image from data")
            }
        } else {
            print("Invalid response or empty data")
        }
    }.resume()
}
