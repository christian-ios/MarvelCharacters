//
//  NetworkService.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ endpoint: URL) async throws -> T
}

class NetworkServiceImpl: NetworkService {
    func request<T: Decodable>(_ endpoint: URL) async throws -> T {
        do {
            var urlComponents = URLComponents(url: endpoint, resolvingAgainstBaseURL: false)
            urlComponents?.addAuthorization(publicKey: Constants.API.apiKey, privateKey: Constants.API.privateKey)
            guard let authorizedUrl = urlComponents?.url else {
                throw NetworkError.invalidURL
            }
            let (data, response) = try await URLSession.shared.data(from: authorizedUrl)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
            
            let decoder = JSONDecoder()
            //Handles decoding strategy for snake case -> camel case
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.networkConnectionError
        }
    }
    
}

enum NetworkError: Error, Equatable {
    case invalidURL
    case noData
    case decodingError
    case serverError(statusCode: Int)
    case networkConnectionError
    case unknown
    
    var errorMessage: String {
        switch self {
        case .invalidURL:
            return String(localized: "Invalid URL.")
        case .noData, .decodingError:
            return String(localized: "No data available.")
        case .serverError(let statusCode):
            return String(localized: "Server error with status code \(statusCode).")
        case .networkConnectionError:
            return String(localized: "Network connection error.")
        case .unknown:
            return String(localized: "Unknown error occurred.")
        }
    }
}
