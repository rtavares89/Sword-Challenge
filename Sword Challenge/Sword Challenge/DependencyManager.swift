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

    var catsUseCases: CatsUseCases
    private var apiClient: ApiClient
    private var catsGateway: CatsGateway
    private var jsonDecoder: JSONDecoder

    private init() { 
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let baseUrl = URL(string: "https://api.thecatapi.com/")!

        self.apiClient = ApiClientImplementation(jsonDecoder: jsonDecoder)
        self.catsGateway = CatsGatewayImplementation(apiClient: apiClient, baseUrl: baseUrl)
        self.catsUseCases = CatsUseCasesImplementation(catsGateway: catsGateway)
    }
}
