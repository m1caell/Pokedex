//
//  PokemonListPresenterTests.swift
//  PokedexTests
//
//  Created by Pablo Trindade on 15/06/19.
//  Copyright © 2019 CWI Software. All rights reserved.
//

@testable import Pokedex
import XCTest

class PokemonListPresenterTests: XCTestCase {
    
    func testFetchData() {
        let expetaction = XCTestExpectation(description: "")
        
        let presenter = PokemonListPresenter()
        let view = PokemonListViewMock() {
            expetaction.fulfill()
        }
        presenter.view = view
        presenter.fetchData()
        
        wait(for: [expetaction], timeout: 1.0)
    }
}
class PokemonListViewMock: PokemonListViewType {
    let fulfill: () -> Void
    
    init (fulfill: @escaping () -> Void) {
        self.fulfill = fulfill
    }
    
    func reloadData() {
        self.fulfill()
    }
}

