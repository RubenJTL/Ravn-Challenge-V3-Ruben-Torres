//
//  PokemonDetailsServiceMock.swift
//  PokemonTests
//
//  Created by Ruben Torres on 3/06/22.
//

import Foundation
import Combine

@testable import Pokemon


final class PokemonDetailServiceMock: PokemonDetailServiceType {
    
    let pokemonSpecie = PokemonSpeciesResponse(
        id: Pokemon.noLegendary.id,
        name: Pokemon.noLegendary.name,
        isLegendary: Pokemon.noLegendary.isLegendary,
        color: PokemonSpeciesResponse.Color(name: Pokemon.noLegendary.color, url: "URL"),
        generation: PokemonSpeciesResponse.Generation(name: Pokemon.noLegendary.generation),
        flavorTextEntries: [
            PokemonSpeciesResponse.FlavorTextEntry(
                flavorText: Pokemon.noLegendary.description,
                language: .init(name: "en", url: "some url"),
                version: .init(name: "omega-ruby", url: "some url"))],
        evolutionChain: .init(url: "https://pokeapi.co/api/v2/evolution-chain/1/"))
    

    static let pokemons = [
        PokemonResponse(
            sprites: .init(
                other: .init(
                    home: .init(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/1.png",
                        frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/1.png"
                    )
                )
            ),
            types: Pokemon.noLegendary.types.map { type in
                PokemonResponse.PokemonType(
                    type: .init(
                        name: type
                    )
                )
            },
            name: Pokemon.noLegendary.name,
            id: Pokemon.noLegendary.id
        ),
        PokemonResponse(
            sprites: .init(
                other: .init(
                    home: .init(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/2.png",
                        frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/2.png"
                    )
                )
            ),
            types: Pokemon.noLegendary.types.map { type in
                PokemonResponse.PokemonType(
                    type: .init(
                        name: type
                    )
                )
            },
            name: "yvisaur",
            id: 2
        ),
        PokemonResponse(
            sprites: .init(
                other: .init(
                    home: .init(
                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/3.png",
                        frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/3.png"
                    )
                )
            ),
            types: Pokemon.noLegendary.types.map { type in
                PokemonResponse.PokemonType(
                    type: .init(
                        name: type
                    )
                )
            },
            name: "vinasaur",
            id: 3
        )
    ]
    let evolves = EvolvesResponse(
        chain: .init(
            species: .init(name: pokemons[0].name),
            evolvesTo: [
                .init(
                    species: .init(name: pokemons[1].name),
                    evolvesTo: [
                        .init(species: .init(name: pokemons[2].name), evolvesTo: [])
                    ]
                )
            ]
        )
    )
    
    func getPokemonSpecies(id: Int) -> AnyPublisher<PokemonSpeciesResponse, Error> {
        return Just(pokemonSpecie)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getPokemon(id: Int) -> AnyPublisher<PokemonResponse, Error> {
        
        return Just(Self.pokemons[id-1])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getSprites(name: String) -> AnyPublisher<PokemonResponse, Error> {
        var id: Int {
            switch name {
            case Pokemon.noLegendary.name :
                return 1
            case "yvisaur":
                return 2
            case "vinasaur":
                return 3
            default:
                return 1
            }
        }
        return Just(Self.pokemons[id])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func getEvolves(stringUrl: String) -> AnyPublisher<EvolvesResponse, Error> {
        return Just(evolves)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    
    
}
