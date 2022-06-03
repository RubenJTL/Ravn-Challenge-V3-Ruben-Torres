//
//  EvolutionAvatar.swift
//  Pokemon
//
//  Created by Ruben Torres on 3/06/22.
//

import SwiftUI

struct EvolutionAvatar: View {
    let url: URL?
    var body: some View {
            ZStack {
                Circle()
                    .fill()
                    .foregroundColor(.cellBackground)
                
                Avatar(url: url, size: DrawingConstants.avatarSize)
            }
            .frame(width: DrawingConstants.avatarSize.width, height: DrawingConstants.avatarSize.width)
    }
    
    private struct DrawingConstants {
        static let avatarSize: CGSize = CGSize(width: 80, height: 80)
    }
}

struct EvolutionAvatar_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionAvatar(url: PokemonDex.legendary.frontalSprite)
    }
}
