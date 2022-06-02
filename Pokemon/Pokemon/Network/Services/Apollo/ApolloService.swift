//
//  Apollo.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Combine
import Apollo

protocol ApolloServiceType {
    func execute<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error>

}

final class ApolloService: ApolloServiceType {
    private let client: ApolloClient
    
    init(client: ApolloClient) {
        self.client = client
    }
    
    func execute<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error> {
        Future<T.Data, Error> { [weak client] promise in
            client?.fetch(query: query) { result in
                switch result {
                case .success(let graphQLResult):
                    guard let data = graphQLResult.data else {
                        promise(.failure(NetworkError.failLoadData))
                        return
                    }
                    promise(.success(data))
                    
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
