//
//  CharacterRepositoryImpl.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

class CharacterRepositoryImpl: CharacterRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchCharacters(page: Int) async throws -> [MarvelCharacter] {
        guard var urlComponents = URLComponents(url: Constants.API.charactersListUrl(), resolvingAgainstBaseURL: false) else { throw NetworkError.invalidURL }
        let limit = 30
        let offset = (page - 1) * limit
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        let response: MarvelAPIResponse<MarvelCharacter> = try await networkService.request(url)
        return response.data.results
    }
}
