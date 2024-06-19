//
//  ComicRepository.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

protocol ComicRepository {
    func fetchComics(characterId: Int, page: Int) async throws -> [Comic]
}
