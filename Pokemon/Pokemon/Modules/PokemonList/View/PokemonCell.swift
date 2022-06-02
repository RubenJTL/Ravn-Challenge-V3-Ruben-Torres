//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import SwiftUI

struct PokemonCell: View {
    private let pokemonImageSize: CGSize = .init(width: 72, height: 72)
    private let pokemonImageOffset: CGFloat =  -48.0
    private let typeImageSize: CGSize = .init(width: 30, height: 30)
    private let borderRadius: CGFloat = 16
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: borderRadius)
                .foregroundColor(Color.cellBackground)
            HStack(alignment: .center) {
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/4.png"),
                           content: { image in
                    image.resizable()
                        .frame(maxWidth: pokemonImageSize.width, maxHeight: pokemonImageSize.height)
                        .shadow(color: Color.black.opacity(0.50), radius: 4, x: 0, y: 4)

                },
                           placeholder: {
                    ProgressView()
                })
                .padding(.leading, pokemonImageOffset)

                VStack(alignment: .leading) {
                    Text("Charizard")
                        .textStyle(with: .bodyHighEmphasis)
                    Text("#006")
                        .textStyle(with: .body)
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
        Group {
            PokemonCell()
                .preferredColorScheme(.light)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 24.0)
            .frame(height: 100.0)
            PokemonCell()
                .preferredColorScheme(.dark)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 24.0)
                .frame(height: 100.0)
        }
            
    }
}
