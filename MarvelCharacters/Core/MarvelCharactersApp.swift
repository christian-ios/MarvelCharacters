//
//  MarvelCharactersApp.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI
import SwiftData

@main
struct MarvelCharactersApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharactersListView(viewModel: CharacterListViewModel())
            }
        }
    }
}
