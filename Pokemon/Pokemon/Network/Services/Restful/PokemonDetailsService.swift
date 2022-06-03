//
//  PokemonDetailsService.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine

protocol PokemonDetailServiceType {
    func getPokemonSpecies(id: Int) throws -> AnyPublisher<PokemonSpeciesResponse, Error>
    func getPokemon(id: Int) throws -> AnyPublisher<PokemonResponse, Error>
//    func getEvolves(id: Int) throws -> AnyPublisher<EvolvesResponse, Error>
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

    func getPokemonSpecies(id: Int) throws -> AnyPublisher<PokemonSpeciesResponse, Error> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else {
            throw NetworkError.invalidURL
        }

        return resfulService.execute(for: url)
            .decode(type: PokemonSpeciesResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) throws -> AnyPublisher<PokemonResponse, Error> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/") else {
            throw NetworkError.invalidURL
        }

        return resfulService.execute(for: url)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getSprites(name: String) throws -> AnyPublisher<PokemonResponse, Error> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)/") else {
            throw NetworkError.invalidURL
        }

        return resfulService.execute(for: url)
            .decode(type: PokemonResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
//    func getEvolves(id: Int) throws -> AnyPublisher<EvolvesResponse, Error> {
//        //
//    }
    
}
