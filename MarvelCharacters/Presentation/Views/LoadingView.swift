//
//  LoadingView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI

struct LoadingView: View {
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: .white))
            .frame(width: width, height: height)
    }
}

#Preview {
    LoadingView(width: 100, height: 100)
}
