//
//  CharactersListView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI

struct CharactersListView<ViewModel: CharacterListViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @FocusState private var selectedItem: Int?
    @State private var searchText: String = ""
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                titleView("POPULAR CHARACTERS")
                characterScrollView()
            }
            .task {
                await viewModel.loadCharacters()
            }
            .onChange(of: selectedItem) { oldValue, newValue in
                if newValue == viewModel.characters.count - 1 {
                    viewModel.loadMoreCharacters()
                }
            }
        }
    }
    
    @ViewBuilder
    private func titleView(_ title: String) -> some View {
        Text(title)
            .font(.title2)
            .bold()
            .padding(.leading)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private func characterScrollView() -> some View {
        GeometryReader { geometry in
            let cellSize = geometry.size.width * 0.15
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 40) {
                    if let errorMessage = viewModel.errorMessage {
                        ErrorView(message: errorMessage)
                    } else {
                        ForEach(Array(viewModel.characters.enumerated()), id: \.offset) { index, character in
                            NavigationLink(destination: CharacterDetailView(viewModel: CharactersDetailsViewModel(), character: character)) {
                                CharacterView(character: character, isSelected: selectedItem == index, cellSize: cellSize)
                                    .accessibilityIdentifier("character_\(index)")
                            }
                            .buttonStyle(ClearButtonStyle())
                            .focused($selectedItem, equals: index)
                        }
                    }
                }
                .padding(.horizontal)
                
            }
            .accessibilityIdentifier("charactersList")
            
        }
    }
}

struct ClearButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(.white)
            .background(Color.clear)
            .cornerRadius(8.0)
    }
}
#Preview {
    let networkService = NetworkServiceImpl()
    let repository = CharacterRepositoryImpl(networkService: networkService)
    let fetchCharactersUseCase = FetchCharactersUseCase(repository: repository)
    let viewModel = CharacterListViewModel(fetchCharactersUseCase: fetchCharactersUseCase)
    return CharactersListView(viewModel: viewModel)
}
