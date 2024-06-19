//
//  ComicRepositoryImpl.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

class ComicRepositoryImpl: ComicRepository {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
    }
    func fetchComics(characterId: Int, page: Int) async throws -> [Comic] {
        guard var urlComponents = URLComponents(url: Constants.API.comicsListUrl(), resolvingAgainstBaseURL: false) else { throw NetworkError.invalidURL }
        let limit = 30
        let offset = (page - 1) * limit
        urlComponents.queryItems = [
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "characters", value: "\(characterId)"),
            URLQueryItem(name: "offset", value: "\(offset)")
        ]
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        let response: MarvelAPIResponse<Comic> = try await networkService.request(url)
        return response.data.results
    }
}
