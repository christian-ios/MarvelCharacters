//
//  CharactersListViewModel.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation
import Combine
import SwiftUI

protocol CharacterListViewModelProtocol: ObservableObject {
    var characters: [MarvelCharacter] { get }
    func loadCharacters() async
    func loadMoreCharacters()
    var isLoading: Bool { get }
    var errorMessage: String? { get }
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    @Published var characters: [MarvelCharacter] = []
    @Published var errorMessage: String?
    private let fetchCharactersUseCase: FetchCharactersUseCase
    private var currentPage = 0
    var isLoading = false
    var noMoreResults = false
    
    init(fetchCharactersUseCase: FetchCharactersUseCase = FetchCharactersUseCase(repository: CharacterRepositoryImpl(networkService: NetworkServiceImpl()))) {
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }
    
    func loadMoreCharacters() {
        Task {
            await loadCharacters()
        }
    }
    
    @MainActor
    func loadCharacters() async {
        guard !isLoading, noMoreResults == false else { return }
        isLoading = true
        currentPage += 1
        do {
            let characters = try await fetchCharactersUseCase.execute(page: currentPage)
            if characters.isEmpty {
                self.isLoading = false
                noMoreResults = true
                if self.characters.isEmpty {
                    errorMessage = String(localized: "No characters were found")
                }
                return
            }
            self.characters.append(contentsOf: characters)
        } catch {
            noMoreResults = true
            // Only show error message if no characters are loaded
            if self.characters.isEmpty {
                if let networkError = error as? NetworkError {
                    errorMessage = networkError.errorMessage
                } else {
                    errorMessage = error.localizedDescription
                }
            }
        }
        self.isLoading = false
        
    }
}
