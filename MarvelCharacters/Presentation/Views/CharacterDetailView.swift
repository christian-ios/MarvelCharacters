//
//  CharacterDetailView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI

struct CharacterDetailView<ViewModel: CharactersDetailsViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @FocusState private var selectedComic: Int?
    
    let character: MarvelCharacter
    
    init(viewModel: ViewModel, character: MarvelCharacter) {
        self.character = character
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    characterImage(with: geometry)
                    characterInfo
                }
                comicsList()
            }
            .accessibilityIdentifier("characterDetailView")
        }
        .task {
            await viewModel.loadComics(characterId: character.id)
        }
    }
    
    @ViewBuilder
    private func characterImage(with geometry: GeometryProxy) -> some View {
        if let imageUrl = URL(string: character.thumbnail.imagePath.secureUrl()) {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .clipped()
                    .overlay(
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.9)]),
                                       startPoint: .leading,
                                       endPoint: .trailing)
                        .blendMode(.multiply)
                        .clipped()
                    )
            } placeholder: {
                ProgressView()
                    .frame(width: 120, height: 120)
            }
        }
    }
    
    @ViewBuilder
    private var characterInfo: some View {
        Text(character.name.uppercased())
            .font(Font.system(size: 25))
            .bold()
            .padding(.top, 10)
        Spacer()
    }
    
    @ViewBuilder
    private func comicsList() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {
                if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage)
                } else {
                    ForEach(Array(viewModel.comics.enumerated()), id: \.offset) { index, comic in
                        ComicView(comic: comic,isSelected: selectedComic == index)
                            .focusable()
                            .focused($selectedComic, equals: index)
                            .onTapGesture {
                                self.selectedComic = index
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        .onChange(of: selectedComic) { oldValue, newValue in
            if newValue == viewModel.comics.count - 1 {
                viewModel.loadMoreComics(characterId: character.id)
            }
        }
    }
}
#Preview {
    let networkService = NetworkServiceImpl()
    let repository = ComicRepositoryImpl(networkService: networkService)
    let fetchComicsUseCase = FetchComicsUseCase(repository: repository)
    let viewModel = CharactersDetailsViewModel(fetchComicsUseCase: fetchComicsUseCase)
    return CharacterDetailView(viewModel: viewModel, character: MarvelCharacter.placeHolder)
}
