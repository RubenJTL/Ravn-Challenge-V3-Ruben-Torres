// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetAllPokemonsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query GetAllPokemons {
      allPokemon {
        __typename
        name
        id
        generation
        types {
          __typename
          name
        }
      }
    }
    """

  public let operationName: String = "GetAllPokemons"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("allPokemon", type: .list(.object(AllPokemon.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allPokemon: [AllPokemon?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "allPokemon": allPokemon.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }])
    }

    /// get range of Pokemon starting from start variable
    public var allPokemon: [AllPokemon?]? {
      get {
        return (resultMap["allPokemon"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [AllPokemon?] in value.map { (value: ResultMap?) -> AllPokemon? in value.flatMap { (value: ResultMap) -> AllPokemon in AllPokemon(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [AllPokemon?]) -> [ResultMap?] in value.map { (value: AllPokemon?) -> ResultMap? in value.flatMap { (value: AllPokemon) -> ResultMap in value.resultMap } } }, forKey: "allPokemon")
      }
    }

    public struct AllPokemon: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Pokemon"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .scalar(String.self)),
          GraphQLField("id", type: .scalar(Int.self)),
          GraphQLField("generation", type: .scalar(String.self)),
          GraphQLField("types", type: .list(.object(`Type`.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String? = nil, id: Int? = nil, generation: String? = nil, types: [`Type`?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Pokemon", "name": name, "id": id, "generation": generation, "types": types.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var id: Int? {
        get {
          return resultMap["id"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      /// which generation the queried Pokemon debuted in
      public var generation: String? {
        get {
          return resultMap["generation"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "generation")
        }
      }

      /// array of all the different Types of the queried Pokemon
      public var types: [`Type`?]? {
        get {
          return (resultMap["types"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [`Type`?] in value.map { (value: ResultMap?) -> `Type`? in value.flatMap { (value: ResultMap) -> `Type` in `Type`(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [`Type`?]) -> [ResultMap?] in value.map { (value: `Type`?) -> ResultMap? in value.flatMap { (value: `Type`) -> ResultMap in value.resultMap } } }, forKey: "types")
        }
      }

      public struct `Type`: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Type"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Type", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }
    }
  }
}
