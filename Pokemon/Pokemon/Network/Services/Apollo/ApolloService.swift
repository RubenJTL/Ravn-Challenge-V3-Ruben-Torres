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
    func fetch<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error>

}

final class ApolloService: ApolloServiceType {
    private var apolloClient: ApolloClient
    
    init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }
    
    func fetch<T: GraphQLQuery>(query: T) -> AnyPublisher<T.Data, Error> {
        Future<T.Data, Error> { [weak apolloClient] promise in
            apolloClient?.fetch(query: query) { result in
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
