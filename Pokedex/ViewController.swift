//
//  ViewController.swift
//  Pokedex
//
//  Created by Pablo Trindade on 05/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    let requestMaker = RequestMaker()
    let cellIdentifier = "CellIdentifier"
    
    var fruits: [String] = []
    var pokemons: PokemonList? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fruits = ["Apple", "Pineapple", "Orange", "Blackberry", "Banana", "Pear", "Kiwi", "Strawberry", "Mango", "Walnut", "Apricot", "Tomato", "Almond", "Date", "Melon", "Water Melon", "Lemon", "Coconut", "Fig", "Passionfruit", "Star Fruit", "Clementin", "Citron", "Cherry", "Cranberry"]
        
        requestMaker.make(withEndpointUrl: .list) { (pokemonList: PokemonList) in
            self.pokemons = pokemonList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokemons?.pokemons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath as IndexPath) as? PokemonTableViewCell {
            if let pokemon = self.pokemons?.pokemons[indexPath.row] {
                cell.config(pokemon: pokemon)
            }
            
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fruit = fruits[indexPath.row]
        print(fruit)
    }
}

