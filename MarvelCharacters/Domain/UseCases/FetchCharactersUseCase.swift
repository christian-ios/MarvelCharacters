//
//  FetchCharactersUseCase.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

class FetchCharactersUseCase {
    private let repository: CharacterRepository
    
    init(repository: CharacterRepository) {
        self.repository = repository
    }
    
    func execute(page: Int) async throws -> [MarvelCharacter] {
        return try await repository.fetchCharacters(page: page)
    }
}
