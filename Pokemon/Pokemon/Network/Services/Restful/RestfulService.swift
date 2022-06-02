//
//  RestfulService.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine

protocol RestfulServiceType {
    func execute(for url: URL) -> AnyPublisher<Data, Error>
}

final class RestfulService: RestfulServiceType {
    let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute(for url: URL) -> AnyPublisher<Data, Error> {
        session.dataTaskPublisher(for: url)
            .map(\.data)
            .mapError {
                $0 as Error
            }
            .eraseToAnyPublisher()
    }
}
