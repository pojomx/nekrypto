//
//  Crypto+Image.swift
//  Nekrypto
//
//  Created by Alan Milke on 21/05/25.
//

import Foundation
import SwiftUI

extension Crypto {
    // Addind this here to handle cache instead of using Async Image, downlaods the picture
    // the first time only, and stores it in swift data Picture field.
    
    // This code is mostly from: https://stackoverflow.com/questions/32322386/how-to-download-multiple-files-sequentially-using-urlsession-downloadtask-in-swi
    // Allow to download "cache" for images, and store that. Modified it to store this in SwiftData instead.
    
    func downloadPicture() async throws -> Data? {
        // if picture is already set, just give it back.
        if picture != nil { return picture }
        // if not, download it.
        guard let imageURL = URL(string: image) else { return nil }
        // Ignoring result... for now... anything fails, go to template.
        let (data, _) = try await URLSession.shared.data(from: imageURL)
        //set data to object to keeep it.
        self.picture = data
        // return data to continue...
        return data
    }
}
