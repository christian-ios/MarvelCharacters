//
//  String+Extensions.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import Foundation

extension String {
    func secureUrl() -> String {
        return self.replacingOccurrences(of: "http://", with: "https://")
    }
}
