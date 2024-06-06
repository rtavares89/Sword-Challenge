//
//  File.swift
//  
//
//  Created by Ricardo Tavares on 06/06/2024.
//

import Foundation

public protocol CatsUseCases {
    func fetchCatBreeds(page: Int) async throws -> [CatBreed]
    func downloadCatImage(imageId: String) async throws
}

public final class CatsUseCasesImplementation: CatsUseCases {

    private let catsGateway: CatsGateway

    public init(catsGateway: CatsGateway) {
        self.catsGateway = catsGateway
    }

    public func fetchCatBreeds(page: Int) async throws -> [CatBreed] {
        try await catsGateway.fetchCatBreeds(page: page)
    }

    public func downloadCatImage(imageId: String) async throws {
        
    }
}
