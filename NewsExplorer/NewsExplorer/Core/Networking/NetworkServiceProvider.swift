//
//  NetworkServiceProvider.swift
//  NewsExplorer
//
//  Created by Aleksandra on 04.10.2023.
//

import Combine
import Foundation

protocol NetworkServiceProvider {
    associatedtype E: Endpoint

    func execute(endpoint: E) -> AnyPublisher<Void, NetworkError>
}

class NetworkServiceProviderImpl<E: Endpoint>: NetworkServiceProvider {
    private let baseURL: URL
    private let networkManager: NetworkManager
    private let encoder: JSONEncoder

    init(baseURL: URL,
         networkManager: NetworkManager,
         encoder: JSONEncoder) {
        self.baseURL = baseURL
        self.networkManager = networkManager
        self.encoder = encoder
    }

    func execute(endpoint: E) -> AnyPublisher<Void, NetworkError> {
        do {
            let request = try endpoint.build(baseURL: baseURL, encoder: encoder)
            return networkManager.execute(request: request)
                .map { _ in }
                .mapError { [unowned self] error -> NetworkError in
                    let mappedError = handleError(error)
                    debugPrint(mappedError.errorDescription ?? "")
                    return mappedError
                }
                .eraseToAnyPublisher()
        } catch let error as RequestBuilderError {
            debugPrint(error.localizedDescription)
            return Fail(error: NetworkError.cannotBuildRequest(reason: error))
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.unknown)
                .eraseToAnyPublisher()
        }
    }

    private func handleError(_ error: Error) -> NetworkError {
        switch error {
        case let error as Swift.DecodingError:
            return .decodingError(error)
        case let urlError as URLError:
            return .badURL(urlError)
        case let error as NetworkError:
            return error
        default:
            return NetworkError.unknown
        }
    }
}
