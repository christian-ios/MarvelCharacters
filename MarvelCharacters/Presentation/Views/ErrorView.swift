//
//  ErrorView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/19/24.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    var body: some View {
        Text(message)
            .font(Font.system(size: 25))
            .bold()
            .padding(.top, 10)
        Spacer()
    }
}

#Preview {
    ErrorView(message: "Error")
}
