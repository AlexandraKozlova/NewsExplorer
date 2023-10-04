//
//  Endpoint.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Foundation

enum RequestBody {
    case rawData(Data)
    case encodable(Encodable)
}

typealias HTTPQueries = [String: String]
typealias HTTPHeaders = [String: String]

protocol RequestBuilder {
    func build(baseURL: URL, encoder: JSONEncoder) throws -> URLRequest
}

protocol Endpoint: RequestBuilder {
    var baseURL: URL? { get }
    var path: String? { get }
    var method: HTTPMethod { get }
    var queries: HTTPQueries { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    var baseURL: URL? { return nil }

    var queries: HTTPQueries { [:] }

    func build(baseURL: URL, encoder: JSONEncoder) throws -> URLRequest {
        var fullURL = self.baseURL ?? baseURL
        if let path = path {
            fullURL = fullURL.appendingPathComponent(path)
        }
        guard var components = URLComponents(url: fullURL, resolvingAgainstBaseURL: true) else {
            throw RequestBuilderError.unableToCreateComponents
        }
        components.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let requestURL = components.url else {
            throw RequestBuilderError.unableToBuildUrl
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { (key: String, value: String) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}

