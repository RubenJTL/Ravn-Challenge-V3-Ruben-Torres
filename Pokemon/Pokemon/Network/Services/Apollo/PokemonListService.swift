//
//  PokemonListService.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine
import Apollo

protocol PokemonListServiceType {
    func getAllPokemons() -> AnyPublisher<PokemonListResponse, Error>
}

final class PokemonListService: PokemonListServiceType {
    let apolloService: ApolloServiceType
    
    init(apolloService: ApolloServiceType = ApolloService(client: ApolloClient(url: URL(string: "https://dex-server.herokuapp.com/")!))) {
        self.apolloService = apolloService
    }
    
    func getAllPokemons() -> AnyPublisher<PokemonListResponse, Error> {
        apolloService.execute(query: GetAllPokemonsQuery())
            .map { data in
                guard let serialized = try? JSONSerialization.data(
                    withJSONObject: data.jsonObject,
                    options: []
                ) else { return nil }
                return serialized
            }
            .compactMap { $0 }
            .decode(type: PokemonListResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
