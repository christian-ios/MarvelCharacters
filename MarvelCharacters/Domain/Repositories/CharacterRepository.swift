//
//  CharacterRepository.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

protocol CharacterRepository {
    func fetchCharacters(page: Int) async throws -> [MarvelCharacter]
}
