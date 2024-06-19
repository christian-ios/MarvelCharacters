//
//  ComicView.swift
//  MarvelCharacters
//
//  Created by Christian Curiel on 6/18/24.
//

import SwiftUI

struct ComicView: View {
    let comic: Comic
    let isSelected: Bool
    
    private var dateFormatted: DateFormatter {
        let formatted = DateFormatter()
        formatted.dateFormat = "MMM d, YYYY"
        return formatted
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            comicImage
            comicDetails
        }
        .padding(.top)
        .frame(width: 150)
    }
    
    @ViewBuilder
    private var comicImage: some View {
        if let imageUrl = URL(string: comic.thumbnail?.imagePath.secureUrl() ?? "") {
            AsyncImage(url: imageUrl) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 200)
                    .clipped()
                    .overlay(Rectangle().stroke(isSelected ? Color.red : Color.clear, lineWidth: 2))
            } placeholder: {
                LoadingView(width: 150, height: 200)
            }
        } else {
            Color.gray
                .frame(width: 150, height: 200)
        }
    }
    
    @ViewBuilder
    private var comicDetails: some View {
        VStack(alignment: .leading) {
            Text(comic.title.uppercased())
                .fontWeight(.heavy)
                .font(.system(size: 13))
                .fixedSize(horizontal: false, vertical: true)
                .foregroundColor(.white)
            
            if let issueNumber = comic.issueNumber {
                Text("Issue # \(issueNumber)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            
            if let dateString = comic.dates?.first?.date,
               let date = ISO8601DateFormatter().date(from: dateString) {
                Text("\(dateFormatted.string(from: date))")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
        .frame(width: 150, alignment: .leading)
    }
}

#Preview {
    ComicView(comic: Comic.previewComic, isSelected: false)
}
