//
//  FetchComicsUseCase.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

class FetchComicsUseCase {
    private let repository: ComicRepository
    
    init(repository: ComicRepository = ComicRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(characterId: Int, page: Int) async throws -> [Comic] {
        return try await repository.fetchComics(characterId: characterId, page: page)
    }
}
