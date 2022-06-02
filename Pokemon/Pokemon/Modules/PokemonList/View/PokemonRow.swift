//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import SwiftUI

struct PokemonRow: View {
    private let pokemonImageSize: CGSize = .init(width: 72, height: 72)
    private let pokemonImageOffset: CGSize = .init(width: -40.0, height: 0)
    private let typeImageSize: CGSize = .init(width: 30, height: 30)
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.green)
            HStack(spacing: .zero) {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/6.png"),
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: pokemonImageSize.width, maxHeight: pokemonImageSize.height)
                },
                           placeholder: {
                    ProgressView()
                })
                .padding(.leading, pokemonImageOffset.width)
                //                    .frame(width: <#T##CGFloat?#>, height: <#T##CGFloat?#>, alignment: <#T##Alignment#>)
                VStack(alignment: .leading) {
                    Text("charizard")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    Text("#006")
                }
                .padding(.leading, 8.0)
                
                Spacer()
            }
            .padding(.horizontal, 16.0)
        }
        .listRowSeparator(.hidden)
        .padding(.leading, 24)
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow()
            .previewLayout(.sizeThatFits)
    }
}
