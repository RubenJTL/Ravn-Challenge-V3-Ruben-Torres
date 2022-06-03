//
//  EvolutionInfo.swift
//  Pokemon
//
//  Created by Ruben Torres on 3/06/22.
//

import SwiftUI

struct EvolutionInfo: View {
    let url: URL?
    let name: String
    let id: Int
    
    var body: some View {
        VStack {
            EvolutionAvatar(url: url)
            Text(name)
                .textStyle(with: .bodyHighEmphasis)
            Text(id.formattedId)
                .textStyle(with: .body)
        }
    }
}

struct EvolutionInfo_Previews: PreviewProvider {
    static var previews: some View {
        EvolutionInfo(
            url: PokemonDex.noLegendary.frontalSprite,
            name: PokemonDex.noLegendary.name,
            id: PokemonDex.noLegendary.id
        )
    }
}
