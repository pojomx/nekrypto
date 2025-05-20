//
//  Item.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
