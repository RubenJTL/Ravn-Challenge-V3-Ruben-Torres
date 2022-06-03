//
//  PokemonDetailViewTest.swift
//  PokemonTests
//
//  Created by Ruben Torres on 3/06/22.
//

import XCTest
@testable import Pokemon

class PokemonDetailViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewModel() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        var pokemon = Pokemon.noLegendary
        pokemon.evolves = [
            Pokemon.Evolve.init(
                id: 2,
                name: "Yvisaur",
                sprites: .init(
                    defaultFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/2.png"),
                    shinyFront: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/2.png")
                )
            )
        ]
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        
        //Then
        XCTAssertEqual(viewModel.pokemon.name, pokemon.name)
    }

    //MARK: - Test background colors
    
    func testBackgroundColorIsYellow() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "yellow"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pYellow)
    }
    
    func testBackgroundColorIsPurple() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "purple"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pPurple)
    }
    
    func testBackgroundColorIsPink() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "pink"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pPink)
    }
    
    func testBackgroundColorIsWhite() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "white"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pWhite)
    }
    
    func testBackgroundColorIsRed() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "red"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pRed)
    }
    
    func testBackgroundColorIsBlack() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "black"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pBlack)
    }
    
    func testBackgroundColorIsBlue() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "blue"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pBlue)
    }
    
    func testBackgroundColorIsBrown() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "brown"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pBrown)
    }
    
    func testBackgroundColorIsGray() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "gray"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pGray)
    }
    
    func testBackgroundColorIsGreen() throws {
        //Given
        let service = PokemonDetailServiceMock()
        let viewModel = PokemonDetailsViewModel(pokemonId: 1, service: service)
        
        //When
        let _ = XCTWaiter().wait(for: [XCTestExpectation()], timeout: 1)
        viewModel.pokemon.color = "green"
        
        //Then
        XCTAssertEqual(viewModel.backgroundColor, .pGreen)
    }
    
}
