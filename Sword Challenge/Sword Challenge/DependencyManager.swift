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
    private var catsGateway: CatsGateway
    private var jsonDecoder: JSONDecoder

    private init() { 
        self.jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        self.catsGateway = CatsGatewayImplementation(jsonDecoder: jsonDecoder)
        self.catsUseCases = CatsUseCasesImplementation(catsGateway: catsGateway)
    }
}
