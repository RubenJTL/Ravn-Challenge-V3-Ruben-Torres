//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation


import Combine

struct PokemonSpeciesResponse: Codable {
    struct Color: Codable, Equatable {
        let name: String
        let url: String
    }
    
    struct FlavorTextEntry: Codable, Equatable {
        struct Language: Codable, Equatable {
            let name: String
            let url: String
        }
        
        struct Version: Codable, Equatable {
            let name: String
            let url: String
        }
        
        let flavorText: String
        let language: Language
        let version: Version
    }
    
    struct Generation: Codable {
        let name: String
    }
    
    struct EvolutionChain: Codable {
        let url: String
    }
    
    let id: Int
    let name: String
    let isLegendary: Bool
    let color: Color
    let generation: Generation
    let flavorTextEntries: [FlavorTextEntry]
    let evolutionChain: EvolutionChain
}


struct PokemonResponse: Codable {
    
    struct HomeSprites: Codable {
        let frontDefault: String
        let frontShiny: String
    }

    struct OtherSprites: Codable {
        let home: HomeSprites
    }

    struct PokemonSprites: Codable {
        let other: OtherSprites
    }

    struct SomeType: Codable {
        let name: String
    }
    struct PokemonType: Codable {
        let type: SomeType
    }

    let sprites: PokemonSprites
    let types: [PokemonType]
    let name: String
    let id: Int
}


struct EvolvesResponse: Codable {
    
    struct Species: Codable {
        let name: String
    }

    struct ChainLink: Codable {
        let species : Species
        let evolvesTo: [ChainLink]
    }
    let chain: ChainLink
}
