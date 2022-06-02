//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation

struct Pokemon {
    let id: Int
    var name: String
    let defaultFrontalSprite: URL?
    let shinyFrontalSprite: URL?
    let types: [PokemonType]
    let generation: String
    
    // Pokemon Details
    var color: PokemonColor?
    var evolvesTo: [PokemonEvolution]?
    var description: String?
    var isLegendary: Bool?
}

struct PokemonType {
    let name: String
}

struct PokemonColor {
    let name: String
}

struct PokemonEvolution {
    let id: Int
}
