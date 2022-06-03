//
//  PokemonDetailsService.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine

protocol PokemonDetailServiceType {
    func getPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error>
    func getPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error>
    func getSprites(name: String) -> AnyPublisher<PokemonResponse, Error>
    func getEvolves(stringUrl: String) -> AnyPublisher<EvolvesResponse, Error>
}

final class PokemonDetailService: PokemonDetailServiceType {
    let resfulService: RestfulServiceType
    let decoder: JSONDecoder
    
    init(
        decoder: JSONDecoder = JSONDecoder(),
        resfulService: RestfulServiceType = RestfulService()
    ) {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
        self.resfulService = resfulService
    }
    
    func getPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/")!
        
        return resfulService.execute(for: url)
            .decode(type: PokemonSpeciesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
        
        return resfulService.execute(for: url)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getSprites(name: String) -> AnyPublisher<PokemonResponse, Error> {
       let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)/")!
        
        return resfulService.execute(for: url)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
    func getEvolves(stringUrl: String) -> AnyPublisher<EvolvesResponse, Error> {
        let url = URL(string: stringUrl)!
        return resfulService.execute(for: url)
            .decode(type: EvolvesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
}
