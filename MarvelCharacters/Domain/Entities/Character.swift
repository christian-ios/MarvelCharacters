//
//  Character.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

struct MarvelCharacter: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ImageInfo
    let resourceURI: String
    let comics: ComicList
}

struct ImageInfo: Decodable {
    let path: String
    let `extension`: String
    var imagePath: String { path + "." + `extension`}
}

struct ComicList: Decodable {
    let available: Int
    let collectionURI: String
    let items: [ComicSummary]
    let returned: Int
}

struct ComicSummary: Decodable {
    let resourceURI: String
    let name: String
}

extension MarvelCharacter {
    
    static var placeHolder: MarvelCharacter {
        .init(
            id: 1011334,
            name: "3-D Man",
            description: "",
            thumbnail: .init(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784",
                extension: "jpg"
            ),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1011334",
            comics: .init(
                available: 0,
                collectionURI: "http://gateway.marvel.com/v1/public/characters/1011334/comics",
                items: [],
                returned: 0
            )
        )
    }
}
