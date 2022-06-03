//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import Foundation
import SwiftUI
import Combine

final class PokemonDetailsViewModel: ObservableObject {
    private let service: PokemonDetailServiceType
    private var cancelables = Set<AnyCancellable>()
    private var timerPulbisherCancelable: AnyCancellable?
    
    var evolvesPublisher = PassthroughSubject<String, Never>()
    var pokemonEvolvePublisher = PassthroughSubject<String, Never>()
    
    
    @Published var pokemon: Pokemon
    @Published var activeSprite = ActiveSprite.defaultSprite
    @Published var isLoading = false
    @Published var isLoadingEvolutions = false
    
    var backgroundColor: Color {
        switch pokemon.color {
        case "black":
            return .pBlack
        case "blue":
            return .pBlue
        case "brown":
            return .pBrown
        case "gray":
            return .pGray
        case "green":
            return .pGreen
        case "pink":
            return .pPink
        case "purple":
            return .pPurple
        case "red":
            return .pRed
        case "yellow":
            return .pYellow
        default:
            return .pWhite
        }
    }
    
    var evolvesNames = [String]()
    private var pokemonId: Int
    
    init(pokemonId: Int, service: PokemonDetailServiceType = PokemonDetailService()){
        self.service = service
        self.pokemonId = pokemonId
        pokemon = Pokemon.noLegendary
        fetchPokemon()
        setTimerSubscription()
        let pokemonEvolveResult = pokemonEvolvePublisher
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .map {[service] evolveName in
                service.getSprites(name: evolveName)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .share()
        
        pokemonEvolveResult
            .compactMap { $0 }
            .sink(receiveCompletion: { _ in }, receiveValue: {[weak self] result in
                if self?.pokemon.evolves == nil {
                    self?.pokemon.evolves = []
                }
                self?.pokemon.evolves.append(
                    Pokemon.Evolve(
                        id: result.id,
                        name: result.name,
                        sprites: Pokemon.Sprites(
                            defaultFront: URL(string: result.sprites.other.home.frontDefault),
                            shinyFront: URL(string: result.sprites.other.home.frontShiny)
                        )
                    )
                )
            })
            .store(in: &cancelables)
        
        isLoadingEvolutions = true
        let evolveResult = evolvesPublisher
            .map {[service] stringUrl in
                service.getEvolves(stringUrl: stringUrl)
                    .eraseToAnyPublisher()
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .share()
        
        evolveResult
            .map { response -> [String] in
                var species: EvolvesResponse.Species? = nil
                var evolvesTo: [EvolvesResponse.ChainLink]? = nil
                let pokemonName = self.pokemon.name.lowercased()
                if response.chain.species.name == pokemonName {
                    return response.chain.evolvesTo.map { chainLink in
                        chainLink.species.name
                    }
                }
                response.chain.evolvesTo.forEach { chainLink in
                    if chainLink.species.name == pokemonName {
                        species = chainLink.species
                        evolvesTo = chainLink.evolvesTo
                    }
                }
                if species != nil {
                    if let evolves = evolvesTo {
                        return evolves.map { chainLink in
                            chainLink.species.name
                        }
                    }
                }
                return []
            }
            .sink(
                receiveCompletion: { _ in },
                receiveValue: {[weak self] evolveNames in
                    self?.evolvesNames = evolveNames
                }
            )
            .store(in: &cancelables)
        
        
    }
    
    func setTimerSubscription() {
        timerPulbisherCancelable = Timer.publish(every: 1, on: RunLoop.main, in: .common)
            .autoconnect()
            .sink {[weak self] geocoder in
                guard let evolveNames  = self?.evolvesNames , evolveNames.isEmpty else {
                    if let evolveName = self?.evolvesNames.removeFirst() {
                        self?.pokemonEvolvePublisher.send(evolveName)
                    }
                    return
                }
                self?.isLoadingEvolutions = false
                
            }
    }
    
    func fetchPokemon() {
        isLoading = true
        do {
            try service.getPokemonSpecies(id: pokemonId)
                .receive(on: DispatchQueue.main)
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
                    self?.evolvesPublisher.send(response.evolutionChain.url)
                })
                .store(in: &cancelables)
            
            try service.getPokemon(id: pokemonId)
                .receive(on: DispatchQueue.main)
                .compactMap { $0 }
                .map { pokemon -> (String, String, [String]) in
                    let defaultSprite = pokemon.sprites.other.home.frontDefault
                    let shinySprite = pokemon.sprites.other.home.frontShiny
                    let types = pokemon.types.map { type in
                        type.type.name.capitalized
                    }
                    return (defaultSprite, shinySprite, types)
                }
                .sink(receiveCompletion: {[weak self] _ in
                    self?.isLoading = false
                }, receiveValue: {[weak self] defaultSprite, shinySprite, types in
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
