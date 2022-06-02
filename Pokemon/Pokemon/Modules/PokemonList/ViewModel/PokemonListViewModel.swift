//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation
import Combine

class PokemonListViewModel {
    @Published var pokemons = [PokemonDex]()
    @Published var searchText = ""

    private let service: PokemonListServiceType
    
    private var cancellable = Set<AnyCancellable>()
    
    var pokemonsSectioned: [String: [PokemonDex]] {
        Dictionary(grouping: searchResults) {
            $0.generation
        }
    }
    
    var searchResults: [PokemonDex] {
           if searchText.isEmpty {
               return pokemons
           } else {
               return pokemons.filter {
                   return $0.name.starts(with: searchText)
               }
           }
       }
    
    
    init(service: PokemonListServiceType = PokemonListService()){
        self.service = service
    }
    
    func fetchPokemons() {
        service.getAllPokemons()
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] response in
                    self?.pokemons = response.allPokemon
                })
            .store(in: &cancellable)
    }
}
