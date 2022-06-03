//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation

struct Pokemon {
    var id: Int
    var name: String
    var isLegendary: Bool
    var color: String
    var generation: String
    var description: String
    var types: [String]
    var sprites: Sprites
    var evolves: [Evolve]
    
    struct Evolve: Identifiable {
        var id: Int
        var name: String
        var sprites: Sprites
    }
    
    struct Sprites {
        var defaultFront: URL?
        var shinyFront: URL?
    }
}

extension Pokemon {
    static let noLegendary = Pokemon(
        id: 1,
        name: "Bulbasaur",
        isLegendary: false,
        color: "green",
        generation: "generation-i",
        description: "Bulbasaur can be seen napping in bright sunlight.\nThere is a seed on its back. By soaking up the sun’s rays,\nthe seed grows progressively larger.",
        types: ["Bug", "Poison"],
        sprites: Sprites(
            defaultFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"),
            shinyFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png")
        ),
        evolves: []
    )
    
}

