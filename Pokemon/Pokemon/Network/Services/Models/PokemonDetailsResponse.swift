//
//  PokemonDetailsResponse.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation


import Combine

struct PokemonDetailsResponse: Codable, Equatable {

    struct FlavorText: Codable, Equatable {
        let flavorText: String
    }

    struct Color: Codable, Equatable {
        let name: String
    }

    let color: Color
    let flavorTextEntries: [FlavorText]
    let isLegendary: Bool
    let id: Int
    let name: String
}
