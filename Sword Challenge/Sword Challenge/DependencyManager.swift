//
//  DependencyManager.swift
//  Sword Challenge
//
//  Created by Ricardo Tavares on 06/06/2024.
//

import Foundation
import Core
import Data

final class DependencyManager {

    static let shared = DependencyManager()

    let catsUseCases: CatsUseCases
    private let apiClient: ApiClient
    private let favouriteCatsPersistence: FavouriteCatsPersistenceDecorator
    private let catsGateway: CatsGateway
    private let favouriteCatsRepository: FavouriteCatsRepository
    private var jsonDecoder: JSONDecoder

    private init() { 
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let baseUrl = URL(string: "https://api.thecatapi.com/")!

        self.apiClient = ApiClientImplementation(jsonDecoder: jsonDecoder)
        self.favouriteCatsPersistence = FavouriteCatsPersistence()
        self.catsGateway = CatsGatewayImplementation(apiClient: apiClient, baseUrl: baseUrl)
        self.favouriteCatsRepository = FavouriteCatsRepositoryImplementation(persistence: favouriteCatsPersistence)
        self.catsUseCases = CatsUseCasesImplementation(catsGateway: catsGateway, favouriteCatsRepository: favouriteCatsRepository)
    }
}
