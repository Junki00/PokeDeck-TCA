//
//  CounterFeature.swift
//  TCACounter
//
//  Created by drx on 2026/01/02.
//

import ComposableArchitecture
import Foundation

struct PokemonResponse: Codable {
    let name: String
    let sprites: PokemonSprites
}

struct PokemonSprites: Codable {
    let front_default: URL?
}

@Reducer
struct CounterFeature {

    @ObservableState
    struct State: Equatable {
        var count: Int = 1
        var fact: String?
        var imageURL: URL?
    }
    
    enum Action {
        case increment
        case decrement
        case loadPokemon
        case pokemonResponse(name: String, imageURL: URL?)
        case onAppear
        case randomButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.count += 1
                return .send(.loadPokemon)
                
            case .decrement:
                state.count = max(1, state.count - 1)
                return .send(.loadPokemon)
            
            case .randomButtonTapped:
                state.count = Int.random(in: 1...1025)
                return .send(.loadPokemon)
                
            case .onAppear:
                return .send(.loadPokemon)
                
            case .loadPokemon:
                state.fact = nil
                state.imageURL = nil
                
                return .run { [id = state.count] send in
                    let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
                    
                    if let (data, _) = try? await URLSession.shared.data(from: url) {
                        if let model = try? JSONDecoder().decode(PokemonResponse.self, from: data) {
                            let name = model.name.capitalized
                            let imageURL = model.sprites.front_default
                            
                            await send(.pokemonResponse(name: name, imageURL: imageURL))
                        }
                    } else {
                        await send(.pokemonResponse(name: "Not Found", imageURL: nil))
                    }
                }
                
            case let .pokemonResponse(name, imageURL):
                state.fact = name
                state.imageURL = imageURL
                return .none
            }
        }
        ._printChanges()
    }
}
