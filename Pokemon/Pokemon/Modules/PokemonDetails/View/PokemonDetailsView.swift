//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel

    init(pokemonId: Int) {
        viewModel = PokemonDetailsViewModel(pokemonId: pokemonId)
        UISegmentedControl.appearance().selectedSegmentTintColor = .selectedSegment
        UISegmentedControl.appearance().backgroundColor = .segmentBackground
    }
    
    var body: some View {
        ZStack {
            Color.pGreen.opacity(0.5)
            VStack {
                header
                details
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .background(Color.cellBackground, ignoresSafeAreaEdges: [.top])
        .navigationTitle(Text("Pokemon Info"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var header: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .top) {
                HStack {
                    Spacer()
                    if viewModel.pokemon.isLegendary {
                        Image("LegendaryIcon")
                    }
                }
                if viewModel.activeSprite == .defaultSprite {
                    Avatar(
                        url: viewModel.pokemon.sprites.defaultFront,
                        size: DrawingContants.avatarSize
                    )
                } else {
                    Avatar(
                        url: viewModel.pokemon.sprites.shinyFront,
                        size: DrawingContants.avatarSize
                    )
                }
            }
            Picker(
                "Pokemon Sprite",
                selection: $viewModel.activeSprite
            ) {
                Text("Default Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(PokemonDetailsViewModel.ActiveSprite.defaultSprite)
                Text("Shiny Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(PokemonDetailsViewModel.ActiveSprite.shinySprite)
            }
            .pickerStyle(.segmented)
        }
        .padding(.top,24)
        .padding(.horizontal, 16)
    }
    
    private var details: some View {
        ZStack {
            Color.background
                .clipShape( RoundedCorner(radius: 31, corners: [.topLeft, .topRight]) )
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: .zero){
                    Text("\(viewModel.pokemon.id.formattedId) \(viewModel.pokemon.name)")
                        .textStyle(with: .title1)
                    
                    HStack(spacing: .zero) {
                        ForEach(viewModel.pokemon.types, id: \.self) { type in
                            Image("Tag\(type)")
                        }
                    }
                    .padding(.bottom)
                    
                    Text(viewModel.pokemon.generation)
                        .textStyle(with: .body)
                        .padding(.bottom)
                    
                    Text(viewModel.pokemon.description)
                        .multilineTextAlignment(.center)
                        .textStyle(with: .footnote)
                        .padding(.bottom)
                    
                    CustomDivider()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)
                
                evolutions
                Spacer()
            }
        }
    }
    
    private var evolutions: some View {
        ZStack {
            if !viewModel.pokemon.evolves.isEmpty {
                VStack(spacing: .zero) {
                    Text("Evolutions")
                        .textStyle(with: .title3)
                    ScrollView {
                        ForEach(viewModel.pokemon.evolves) { evolve in
                            HStack(spacing: 20) {
                                EvolutionInfo(
                                    url: viewModel.pokemon.sprites.defaultFront,
                                    name: viewModel.pokemon.name,
                                    id: viewModel.pokemon.id)
                                
                                Image(systemName: "arrow.right")
                                EvolutionInfo(
                                    url: evolve.sprites.defaultFront,
                                    name: evolve.name,
                                    id: evolve.id
                                )
                            }
                        }
                        .padding(.top, 16)
                    }
                }
                .padding(.top, 8)
            }
            if viewModel.isLoadingEvolutions {
                ProgressView()
            }
            
        }
        
    }
}

extension PokemonDetailsView {
    private struct DrawingContants {
        static let avatarSize = CGSize(width: 158, height: 158)
    }
}


struct PokemonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonDetailsView(pokemonId: 1)
                .preferredColorScheme(.light)
            PokemonDetailsView(pokemonId: 1)
                .preferredColorScheme(.dark)
        }
        
    }
}
