//
//  MarvelAPIResponse.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

struct MarvelAPIResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let data: MarvelDataContainer<T>
}
