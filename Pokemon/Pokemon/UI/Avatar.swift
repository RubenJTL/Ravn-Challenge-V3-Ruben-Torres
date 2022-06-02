//
//  PokemonImage.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import SwiftUI

struct Avatar: View {
    let url: URL?
    let width: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        AsyncImage(
            url: url,
            content: { image in
                image
                    .resizable()
                    .shadow(
                        color: Color.black.opacity(0.50),
                        radius: 8,
                        x: 0,
                        y: 5
                    )
            },
            placeholder: {
                ProgressView()
            }
        )
        .frame(
            width: width,
            height: height,
            alignment: .center
        )
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Avatar(url: PokemonDex.noLegendary.frontalSprite, width: 72, height: 72)
            Avatar(url: PokemonDex.noLegendary.frontalSprite, width: 158, height: 158)
        }
        
    }
    
}
