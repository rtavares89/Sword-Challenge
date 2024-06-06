//
//  File.swift
//  
//
//  Created by Ricardo Tavares on 06/06/2024.
//

import Foundation

struct CatBreedsRequest {

    static let pageSize = 10
    private let url: URL!

    var request: URLRequest {
        return URLRequest(url: url)
    }

    init(baseUrl: URL, page: Int) {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)!
        components.path = "/v1/breeds"
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(CatBreedsRequest.pageSize)")
        ]

        self.url = components.url
    }
}
