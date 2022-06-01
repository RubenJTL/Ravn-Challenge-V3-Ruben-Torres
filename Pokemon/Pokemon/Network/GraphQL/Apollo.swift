//
//  Apollo.swift
//  Pokemon
//
//  Created by Ruben Torres on 1/06/22.
//

import Foundation
import Apollo

final class Network {
    static let shared = Network()
    private init() {}

    lazy var client = ApolloClient(url: URL(string: "https://dex-server.herokuapp.com/")!)
}
