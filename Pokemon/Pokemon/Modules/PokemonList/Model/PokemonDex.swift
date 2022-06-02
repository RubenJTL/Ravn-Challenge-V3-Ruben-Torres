//
//  Pokemon.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation

struct PokemonDex: Codable {
    let id: Int
    var name: String
    let frontalSprite: URL?
    let types: [PokemonType]
    let generation: String
    var isLegendary: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case generation
    }
    
    struct PokemonType: Codable {
        let name: String
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        name = name.capitalized
        generation = try values.decode(String.self, forKey: .generation)
        types = try values.decode([PokemonType].self, forKey: .types)
        frontalSprite = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/\(id).png")
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(generation, forKey: .generation)
        try container.encode(types, forKey: .types)
    }
}

extension PokemonDex {
    init(
        id: Int,
        name: String,
        frontalSprite: URL?,
        types: [PokemonType],
        generation: String,
        isLegendary: Bool? = nil
    ) {
        self.id = id
        self.name = name
        self.frontalSprite = frontalSprite
        self.types = types
        self.generation = generation
        self.isLegendary = isLegendary
    }
    
    static let noLegendary = PokemonDex(
        id: 1,
        name: "Bulbasaur",
        frontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png"),
        types: [PokemonType(name: "Grass"), PokemonType(name: "Poison")],
        generation: "Generation I"
    )
    
    static let legendary = PokemonDex(
        id: 144,
        name: "Articuno",
        frontalSprite: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/144.png"),
        types: [PokemonType(name: "Ice"), PokemonType(name: "Flying")],
        generation: "Generation I",
        isLegendary: true
    )
}
