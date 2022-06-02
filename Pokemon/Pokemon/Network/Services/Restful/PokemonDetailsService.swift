//
//  PokemonDetailsService.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine

final class PokemonDetailService {
    let resfulService: RestfulServiceType
    let decoder: JSONDecoder

    init(
        decoder: JSONDecoder = JSONDecoder(),
        resfulService: RestfulServiceType = RestfulService()
    ) {
        self.decoder = decoder
        self.resfulService = resfulService
    }

    func getPokemonDetails(id: Int) throws -> AnyPublisher<PokemonDetailsResponse, Error> {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(id)/") else {
            throw NetworkError.invalidURL
        }

        return resfulService.execute(for: url)
            .decode(type: PokemonDetailsResponse.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
