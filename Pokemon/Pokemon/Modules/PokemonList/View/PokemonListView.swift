//
//  PokemonListView.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import SwiftUI

struct PokemonListView: View {
    @ObservedObject var viewModel: PokemonListViewModel
    
    init(viewModel: PokemonListViewModel = PokemonListViewModel()) {
        self.viewModel = viewModel
        UINavigationBar.appearance().backgroundColor = UIColor.cellBackground
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading == true {
                    ProgressView()
                } else {
                    pokemonList
                }
            }
            .background(Color.background, ignoresSafeAreaEdges: .bottom)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Pokemon List")
                        .textStyle(with: .largeTitleHighEmphasis)
                }
            }
            .searchable(text: $viewModel.searchText)
            .background(Color.cellBackground, ignoresSafeAreaEdges: .top)
        }
        
    }
    
    private var divider: some View {
        Divider()
            .foregroundColor(.divider)
    }
    
    private func generationHeader(title: String) -> some View {
        VStack(alignment: .leading, spacing: .zero) {
            Text(title)
                .textStyle(with: .title3)
            divider
        }
    }
    
    private var pokemonList: some View {
        VStack(spacing: .zero) {
            divider
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.generations, id: \.self) {  generation in
                        generationHeader(title: generation)
                        
                        ForEach(viewModel.searchResults[generation] ?? []) { pokemon in
                            NavigationLink {
                                ContentView()
                            } label: {
                                PokemonCell(pokemon: pokemon)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
            }
            
        }
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
            .preferredColorScheme(.dark)
    }
}
