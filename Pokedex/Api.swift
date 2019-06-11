//
//  Api.swift
//  Pokedex
//
//  Created by Pablo Trindade on 10/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import Foundation

struct PokemonList: Codable {
    var pokemons: [Pokemon]
}

struct Pokemon: Codable {
    let id: String
    let name: String
    let image: String
    let types: [PokemonType]
    
    enum PokemonType: String, Codable {
        case grass, bug, poison, fire, normal, water, rock, flying, ground
    }
}

extension Pokemon: CustomStringConvertible {
    var description: String {
        return "\nPokemon: \(self.name.capitalized), com tipos: \(self.types)"
    }
}

extension Pokemon.PokemonType: CustomStringConvertible {
    var description: String {
        return self.rawValue.capitalized
    }
}

class RequestMaker {
    
    enum Endpoint {
        case list
        case details(query: String)
        
        var url: String {
            switch self {
            case .list:
                return "list"
            case let .details(query):
                return "details/\(query)"
            }
        }
    }
    
    let baseUrl = "http://localhost:3000/"
    let session = URLSession.shared
    
    typealias CompletionCallback<T: Decodable> = (T) -> Void
    
    func make<T: Decodable>(withEndpointUrl endpoint: Endpoint, completion: @escaping CompletionCallback<T>) {
        guard let url = URL(string: "\(baseUrl)\(endpoint.url)") else {
            return
        }
        
        let dataTask  = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else {
                print(error!)
                print("Falha ao conectar com server")
                return
            }
            
            guard let data = data else {
                print("Não venho data")
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(decodedObject)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        dataTask.resume()
    }
}






