//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by Ruben Torres on 2/06/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @State private var favoriteColor = 0
    
    init() {
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
            Avatar(url: PokemonDex.noLegendary.frontalSprite, width: 158, height: 158)
            Picker("Pokemon Sprite", selection: $favoriteColor) {
                Text("Default Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(0)
                Text("Shiny Sprite")
                    .textStyle(with: .subheadlineHighEmphasis)
                    .tag(1)
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
                Text(PokemonDex.noLegendary.name)
                    .textStyle(with: .title1)
                HStack(spacing: .zero) {
                    ForEach(PokemonDex.noLegendary.types, id: \.self.name) { type in
                        Image("Tag\(type.name)")
                    }
                }
                .padding(.bottom)
                Text(PokemonDex.noLegendary.generation)
                    .textStyle(with: .body)
                    .padding(.bottom)
                Text("Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.")
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
            PokemonDetailsView()
                .preferredColorScheme(.light)
            PokemonDetailsView()
                .preferredColorScheme(.dark)
        }
        
    }
}
