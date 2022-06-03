//
//  PokemonListViewTest.swift
//  PokemonTests
//
//  Created by Ruben Torres on 3/06/22.
//

import XCTest

@testable import Pokemon

class PokemonListViewModelTest: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInitialViewModel() throws {
        //Given
        let service = PokemonListServiceMock()
        let viewModel = PokemonListViewModel(service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)
        
        //Then
        XCTAssertFalse( viewModel.pokemons.isEmpty)
        XCTAssertFalse( viewModel.searchResults.isEmpty)
        XCTAssertEqual( viewModel.pokemons.count, 2)
    }
    
    func testGenerationIsNotEmpty() throws {
        //Given
        let service = PokemonListServiceMock()
        let viewModel = PokemonListViewModel(service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)
        
        //Then
        XCTAssertEqual(viewModel.generations, ["Generation I"])
    }
    
    func testListViewModel_WhenSearchTextProvided_SearchResultsShouldShowCorrectPokemons() throws {
        //Given
        let service = PokemonListServiceMock()
        let viewModel = PokemonListViewModel(service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 0.5)
        viewModel.searchText = "Bul"
        
        //Then
        XCTAssertFalse( viewModel.searchResults.isEmpty)
        XCTAssertEqual( viewModel.searchResults.count, 1)
    }
    
}
