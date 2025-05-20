//
//  GeckoError.swift
//  Nekrypto
//
//  Created by Alan Milke on 20/05/25.
//

enum GeckoError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case noData
    case unexpected(Error)
}
