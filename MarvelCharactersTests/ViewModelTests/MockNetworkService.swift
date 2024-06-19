//
//  MockNetworkService.swift
//  MarvelCharactersTests
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation
import XCTest
@testable import MarvelCharacters

class MockNetworkService: NetworkService {
    var returnDecodingError = false
    var returnEmpty = false
    
    func request<T>(_ endpoint: URL) async throws -> T where T : Decodable {
        if returnDecodingError {
            throw NetworkError.decodingError
        }
        if returnEmpty {
            return [] as! T
        }
        
        let mockResponse: [MarvelCharacter] = [
            MarvelCharacter.placeHolder,
            MarvelCharacter.placeHolder
        ]
        return mockResponse as! T
    }
}
