//
//  CharacterView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI

struct CharacterView: View {
    let character: MarvelCharacter
    let isSelected: Bool
    let cellSize: CGFloat
    
    var body: some View {
        VStack(alignment: .center) {
            if let imageUrl = URL(string: character.thumbnail.imagePath.secureUrl()) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: cellSize, height: cellSize)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(isSelected ? Color.white : Color.clear, lineWidth: 2))
                } placeholder: {
                    LoadingView(width: cellSize, height: cellSize)
                }
            } else {
                Color.gray
                    .frame(width: cellSize, height: cellSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(isSelected ? Color.blue : Color.white, lineWidth: 2))
            }
            Text(character.name.uppercased())
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .frame(width: cellSize)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding(.top)
    }
}
#Preview {
    CharacterView(character: MarvelCharacter.placeHolder, isSelected: false, cellSize: 100)
}
