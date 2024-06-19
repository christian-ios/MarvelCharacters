//
//  Comic.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

struct Comic: Codable, Identifiable {
    let id: Int
    let title: String
    let thumbnail: Thumbnail?
    let issueNumber: Int?
    let dates: [Dates]?
}

struct Dates: Codable {
    let date: String
}

struct Thumbnail: Codable {
    let path: String
    let `extension`: String
    var imagePath: String { path + "." + `extension`}
}

extension Comic {
    static var previewComic: Comic {
        return Comic(id: 1234, title: "Test Comic", thumbnail: .init(path: "http://i.annihil.us/u/prod/marvel/i/mg/9/b0/4c7d666c0e58a", extension: "jpg"), issueNumber: 1234, dates:nil)
    }
}
