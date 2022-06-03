//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import SwiftUI

struct PokemonCell: View {
    let pokemon: PokemonDex
    
    var body: some View {
        ZStack(alignment: .center) {
            background
            HStack(alignment: .center, spacing: .zero) {
                sprite
                nameAndNumber
                Spacer()
                types
            }
            .padding(.horizontal, 16.0)
        }
        .padding(.leading, 24)
    }
    
    private var background: some View {
        RoundedRectangle(
            cornerRadius: DrawingConstants.borderRadius
        )
        .foregroundColor(Color.cellBackground)
    }
    
    private var sprite: some View {
        Avatar(
            url: pokemon.frontalSprite,
            size: DrawingConstants.pokemonImageSize
        )
        .padding(.leading, DrawingConstants.pokemonImageOffset)
    }
    
    private var nameAndNumber: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text(pokemon.name)
                .textStyle(with: .bodyHighEmphasis)
            Text(pokemon.id.formattedId)
                .textStyle(with: .body)
        }
        .padding(.leading, 8.0)
    }
    
    private var types: some View {
        ForEach(pokemon.types, id: \.self.name) { type in
            Image("Type\(type.name)")
                .resizable()
                .frame(
                    width: DrawingConstants.typeImageSize.width,
                    height: DrawingConstants.typeImageSize.height
                )
        }
    }
    
    private struct DrawingConstants {
        static let pokemonImageSize: CGSize = .init(width: 72, height: 72)
        static let pokemonImageOffset: CGFloat = -48.0
        static let typeImageSize: CGSize = .init(width: 30, height: 30)
        static let borderRadius: CGFloat = 16
    }
}

struct PokemonRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonCell(pokemon: PokemonDex.noLegendary)
                .preferredColorScheme(.light)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 24.0)
                .frame(height: 100.0)
            PokemonCell(pokemon: PokemonDex.legendary)
                .preferredColorScheme(.dark)
                .padding(.vertical, 10.0)
                .padding(.horizontal, 24.0)
                .frame(height: 100.0)
        }
        
    }
}
