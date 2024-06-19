//
//  CharactersListViewModelTests.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//
import Foundation
import XCTest
@testable import MarvelCharacters

class CharactersListViewModelTests: XCTestCase {
    var mockNetworkService: MockNetworkService!
    var mockCharacterRepository: MockCharacterRepository!
    
    override func setUp() async throws {
        mockNetworkService = MockNetworkService()
        mockCharacterRepository = MockCharacterRepository(networkManager: mockNetworkService)
    }
    
    override func tearDown() {
        mockNetworkService = nil
        mockCharacterRepository = nil
    }
    
    @MainActor
    func testLoadCharactersSuccess() async throws {
        // Setup
        let fetchCharactersUseCase = FetchCharactersUseCase(repository: mockCharacterRepository)
        let viewModel = CharacterListViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
        
        // Action
        await viewModel.loadCharacters()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.characters.count, 2)
    }
    
    @MainActor
    func testLoadActualCharactersSuccess() async throws {
        // Setup
        let fetchCharactersUseCase = FetchCharactersUseCase(repository: CharacterRepositoryImpl(networkService: NetworkServiceImpl()))
        let viewModel = CharacterListViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
        
        // Action
        await viewModel.loadCharacters()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssert(!viewModel.characters.isEmpty)
    }
    
    @MainActor
    func testLoadCharactersDecodingError() async throws {
        // Setup
        mockNetworkService.returnDecodingError = true // Simulate failure
        let fetchCharactersUseCase = FetchCharactersUseCase(repository: mockCharacterRepository)
        let viewModel = CharacterListViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
        
        // Action
        await viewModel.loadCharacters()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "No data available.")
        XCTAssertEqual(viewModel.characters.count, 0)
    }
    
    @MainActor
    func testLoadCharactersFailure() async throws {
        // Setup
        mockNetworkService.returnEmpty = true // Simulate failure
        let fetchCharactersUseCase = FetchCharactersUseCase(repository: mockCharacterRepository)
        let viewModel = CharacterListViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
        
        // Action
        await viewModel.loadCharacters()
        
        // Assert
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.errorMessage, "No characters were found")
        XCTAssertEqual(viewModel.characters.count, 0)
    }
}



