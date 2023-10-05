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
    
    func execute<Model: Decodable>(endpoint: E) -> AnyPublisher<Model, NetworkError>
}

final class NetworkServiceProviderImpl<E: Endpoint>: NetworkServiceProvider {
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    // MARK: - Init
    init(networkManager: NetworkManager,
         encoder: JSONEncoder,
         decoder: JSONDecoder) {
        self.networkManager = networkManager
        self.encoder = encoder
        self.decoder = decoder
    }
    
    // MARK: - Internal
    func execute<Model: Decodable>(endpoint: E) -> AnyPublisher<Model, NetworkError> {
        guard let baseURL = endpoint.baseURL else { return Fail(error: NetworkError.badRequest).eraseToAnyPublisher() }
      
        do {
            let request = try endpoint.build(
                baseURL: baseURL,
                encoder: encoder)
            return networkManager.execute(request: request)
                .decode(type: Model.self, decoder: decoder)
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
}

// MARK: - Private setup
private extension NetworkServiceProvider {
    func handleError(_ error: Error) -> NetworkError {
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
