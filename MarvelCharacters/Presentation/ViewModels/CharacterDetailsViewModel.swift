//
//  CharactersListViewModel.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation
import Combine
import SwiftUI

protocol CharactersDetailsViewModelProtocol: ObservableObject {
    var comics: [Comic] { get }
    func loadComics(characterId: Int) async
    func loadMoreComics(characterId: Int)
    var isLoading: Bool { get }
    var errorMessage: String? { get }
}

class CharactersDetailsViewModel: CharactersDetailsViewModelProtocol {
    @Published var comics: [Comic] = []
    @Published var errorMessage: String?
    private let fetchComicsUseCase: FetchComicsUseCase
    private var currentPage = 0
    var isLoading = false
    var noMoreResults = false
    
    init(fetchComicsUseCase: FetchComicsUseCase = FetchComicsUseCase(repository: ComicRepositoryImpl(networkService: NetworkServiceImpl()))) {
        self.fetchComicsUseCase = fetchComicsUseCase
    }
    
    func loadMoreComics(characterId: Int) {
        Task {
            await loadComics(characterId: characterId)
        }
    }
    
    @MainActor
    func loadComics(characterId: Int) async {
        guard !isLoading, noMoreResults == false else { return }
        isLoading = true
        currentPage += 1
        do {
            let comics = try await fetchComicsUseCase.execute(characterId: characterId, page: currentPage)
            if comics.isEmpty {
                self.isLoading = false
                self.noMoreResults = true
                if self.comics.isEmpty {
                    errorMessage = String(localized: "No comics were found")
                }
                return
            }
            self.comics.append(contentsOf: comics)
            
        } catch {
            noMoreResults = true
            // Only show error message if no comics are loaded
            if self.comics.isEmpty {
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
