//
//  Constants.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

struct Constants {
    struct API {
        static let apiKey = "API_KEY"
        static let privateKey = "PRIVATE_KEY"
        static let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public/")!
        
        static func comicsListUrl() -> URL {
            return baseURL.appendingPathComponent("comics")
        }
        
        static func charactersListUrl() -> URL {
            return baseURL.appendingPathComponent("characters")
        }
    }
}
