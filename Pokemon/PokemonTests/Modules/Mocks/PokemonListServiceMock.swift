//
//  PokemonListServiceMock.swift
//  PokemonTests
//
//  Created by Ruben Torres on 3/06/22.
//

import Foundation
import Combine

@testable import Pokemon


final class PokemonListServiceMock: PokemonListServiceType {
    func getAllPokemons() -> AnyPublisher<PokemonListResponse, Error> {
        let pokemons = PokemonListResponse(
            allPokemon: [ PokemonDex.noLegendary, PokemonDex.legendary ]
        )
        
        return Just(pokemons)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
}
