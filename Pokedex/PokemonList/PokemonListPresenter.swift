//
//  PokemonListPresenter.swift
//  Pokedex
//
//  Created by Pablo Trindade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class PokemonListPresenter: NSObject {
    
    weak var view: PokemonListViewType?
    
    private let requestMaker = RequestMaker()
    
    private var pokemonList = [Pokemon]()
    
    private let idsKey = "favorits.ids"
    
    override init() {
        
        if let data = UserDefaults.standard.array(forKey: idsKey) as? [String] {
            self.favoritsIds = Set(data)
        } else {
            self.favoritsIds = []
        }
        
        super.init()
    }
    
    
    private var favoritsIds = Set<String>() {
        didSet{
         print(favoritsIds)
            UserDefaults.standard.set(Array(favoritsIds), forKey: idsKey)
        }
    }
    
    func pokemon(at index: Int) -> Pokemon {
        return pokemonList[index]
    }
    
    func swipe(at index: Int) {
        let pokemonId = pokemon(at: index).id

        guard self.favoritsIds.contains(pokemonId) else {
            self.favoritsIds.insert(pokemonId)
            return
        }
        
        self.favoritsIds.remove(pokemonId)
    }
    
    func swipeAction(for index: Int) -> PokemonSwipeAction {
        return self.favoritsIds.contains(pokemon(at: index).id) ? .removeFavorite : .addFavorite
    }
}

extension PokemonListPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemon", for: indexPath)
        
        if let pokemonCell = cell as? PokemonTableViewCell {
            pokemonCell.config(with: self.pokemonList[indexPath.row])
        }
        
        return cell
    }
    
    func fetchData() {
        requestMaker.make(withEndpoint: .list) { (pokemonList: PokemonList) in
            self.pokemonList = pokemonList.pokemons
            
            DispatchQueue.main.async {
                self.view?.reloadData()
            }
        }
    }
}
