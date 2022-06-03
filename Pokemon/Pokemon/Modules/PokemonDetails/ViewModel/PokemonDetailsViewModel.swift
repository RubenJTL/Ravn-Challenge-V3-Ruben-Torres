//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation
import Combine

final class PokemonDetailsViewModel: ObservableObject {
    private let service: PokemonDetailServiceType
    private var cancelables = Set<AnyCancellable>()
    
    @Published var pokemon: Pokemon
    @Published var activeSprite = ActiveSprite.defaultSprite
    
    private var pokemonId: Int
    
    init(pokemonId: Int, service: PokemonDetailServiceType = PokemonDetailService()){
        self.service = service
        self.pokemonId = pokemonId
        pokemon = Pokemon.noLegendary
        fetchPokemon()
    }
    
    func fetchPokemon() {
        do {
            try service.getPokemonSpecies(id: pokemonId)
                .sink(receiveCompletion: {_ in }, receiveValue: {[weak self] response in
                    let description = response.flavorTextEntries.filter { textEntry in
                        textEntry.version.name == "omega-ruby" && textEntry.language.name == "en"
                    }.first?.flavorText ?? ""
                    self?.pokemon.id = response.id
                    self?.pokemon.name = response.name.capitalized
                    self?.pokemon.isLegendary = response.isLegendary
                    self?.pokemon.color = response.color.name
                    self?.pokemon.generation = response.generation.name.capitalized
                    self?.pokemon.description = description
                    
                })
                .store(in: &cancelables)
            
            try service.getPokemon(id: pokemonId)
                .compactMap { $0 }
                .map { pokemon -> (String, String, [String]) in
                    let defaultSprite = pokemon.sprites.other.home.frontDefault
                    let shinySprite = pokemon.sprites.other.home.frontShiny
                    let types = pokemon.types.map { type in
                        type.type.name.capitalized
                    }
                    return (defaultSprite, shinySprite, types)
                }
                .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] defaultSprite, shinySprite, types in
                    self?.pokemon.sprites = Pokemon.Sprites(
                        defaultFront: URL(string: defaultSprite),
                        shinyFront: URL(string: shinySprite)
                    )
                    self?.pokemon.types = types
                })
                .store(in: &cancelables)
        } catch  {
            //                networkError = .failedToLoadData
            print("fallo")
        }
    }
    
    enum ActiveSprite {
        case defaultSprite, shinySprite
    }
}
