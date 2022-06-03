//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @ObservedObject var viewModel: PokemonDetailsViewModel
    
    @State private var favoriteColor = 0
    
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
        }
        .background(Color.cellBackground, ignoresSafeAreaEdges: [.top])
        .navigationTitle(Text("Pokemon Info"))
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var header: some View {
        VStack(spacing: 10) {
            ZStack {
                if viewModel.activeSprite == .defaultSprite {
                    Avatar(
                        url: viewModel.pokemon.sprites.defaultFront,
                        width: 158,
                        height: 158
                    )
                } else {
                    Avatar(
                        url: viewModel.pokemon.sprites.shinyFront,
                        width: 158,
                        height: 158
                    )
                }
            }
            Picker("Pokemon Sprite",
                   selection: $viewModel.activeSprite) {
                Text("Default Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(PokemonDetailsViewModel.ActiveSprite.defaultSprite)
                Text("Shiny Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(PokemonDetailsViewModel.ActiveSprite.shinySprite)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 16)
        }
    }
    
    private var details: some View {
        ZStack {
            Color.background
                .clipShape( RoundedCorner(radius: 31, corners: [.topLeft, .topRight]) )
                .ignoresSafeArea()
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
                Divider()
                evolutions
                Spacer()
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
        }
        
    }
    
    private func evolutionAvatar(url: URL?) -> some View {
        ZStack {
            Circle()
                .fill()
                .foregroundColor(.cellBackground)
                
            Avatar(url: PokemonDex.noLegendary.frontalSprite, width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
    }
    
    private func evolutionInfo(url: URL?, name: String, id: Int) -> some View {
        VStack {
            evolutionAvatar(url: url)
            Text(name)
                .textStyle(with: .bodyHighEmphasis)
            Text(id.formattedId)
                .textStyle(with: .body)
        }
    }
    
    private var evolutions: some View {
        VStack(spacing: .zero) {
            Text("Evolutions")
                .textStyle(with: .title3)
            ScrollView {
                HStack(spacing: 24) {
                    evolutionInfo(url: PokemonDex.noLegendary.frontalSprite, name: PokemonDex.noLegendary.name, id: PokemonDex.noLegendary.id)
                    Image(systemName: "arrow.right")
                    evolutionInfo(url: PokemonDex.noLegendary.frontalSprite, name: PokemonDex.noLegendary.name, id: PokemonDex.noLegendary.id)
                }
                .padding(.top, 16)
            }
        }
        .padding(.top, 8)
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
