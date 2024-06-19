//
//  MockCharacterRepository.swift
//  MarvelCharactersTests
//
//  Created by Christian Curiel on 6/18/24.
//
import Foundation
import XCTest
@testable import MarvelCharacters

class MockCharacterRepository: CharacterRepository {
    let networkManager: NetworkService
    
    init(networkManager: NetworkService) {
        self.networkManager = networkManager
    }
    
    func fetchCharacters(page: Int) async throws -> [MarvelCharacter] {
        return try await networkManager.request(URL(string: "https://marvel.com")!)
    }
}
