//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation
import Combine



class PokemonListViewModel: ObservableObject {
    
    // MARK: - Output(s)
    @Published var searchResults = [String:[PokemonDex]]()
    @Published var pokemons = [PokemonDex]()
    @Published var searchText = ""
    @Published var isLoading = false
    
    private let service: PokemonListServiceType
    
    private var cancellable = Set<AnyCancellable>()
    
    var generations: [String] {
        searchResults.keys.sorted(by: <).map { String($0) }
    }
    
    init(service: PokemonListServiceType = PokemonListService()){
        self.service = service
        
        setupBindings()
    }
    
    func setupBindings() {
        fetchPokemons()
        
        Publishers.CombineLatest($searchText, $pokemons)
            .map { text, pokemons -> [PokemonDex] in
                if text.isEmpty { return pokemons}
                return pokemons.filter {
                    $0.name.starts(with: text)
                }
            }
            .compactMap { $0 }
            .map({ pokemons -> [String:[PokemonDex]] in
                Dictionary(grouping: pokemons) {
                    $0.generation
                }
            })
            .assign(to: &$searchResults)
        
    }
    
    func fetchPokemons() {
        isLoading = true
        service.getAllPokemons()
            .sink(
                receiveCompletion: { [weak self] _ in
                    self?.isLoading = false
                },
                receiveValue: { [weak self] response in
                    self?.pokemons = response.allPokemon
                })
            .store(in: &cancellable)
    }
}
