//
//  Crypto+Image.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import Foundation
import SwiftUI

extension Crypto {
    
    // WIP
    // Addind this here to handle cache instead of using Async Image, downlaods the picture
    // the first time only, and stores it in swift data Picture field.
    
    func getImage () -> Image {
        // If picture is set, it uses that, if not, it will try to download it.
        if picture == nil {
            // Start downloading picture.
            downloadImage()
            //send a template for now
            return Image("crypto_template")
        } else {
            
            if let picture = picture, let image = UIImage(data: picture) {
                return Image(uiImage: image)
            }
            
            return Image("crypto_template")
        }
    }
    
    func downloadImage() {
        
        guard let url = URL(string: image) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                // woot
                return
            }
            
            //Notify picture is updated
            self.picture = data
        }
        task.resume()
    }
    
}
