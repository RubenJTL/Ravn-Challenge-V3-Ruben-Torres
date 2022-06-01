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
    func getPokemonList() -> AnyPublisher<Array<GetAllPokemonsQuery.Data.AllPokemon>, Error>
}

final class PokemonListService: PokemonListServiceType {
    let apolloService: ApolloServiceType
    
    init(apolloService: ApolloServiceType = ApolloService(apolloClient: ApolloClient(url: URL(string: "https://dex-server.herokuapp.com/")!))) {
        self.apolloService = apolloService
    }
    
    func getPokemonList() -> AnyPublisher<Array<GetAllPokemonsQuery.Data.AllPokemon>, Error> {
        apolloService.fetch(query: GetAllPokemonsQuery())
            .compactMap { $0.allPokemon?.compactMap { $0 } }
            .eraseToAnyPublisher()
    }
    
}
