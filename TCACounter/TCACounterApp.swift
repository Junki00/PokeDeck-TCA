//
//  TCACounterApp.swift
//  TCACounter
//
//  Created by drx on 2026/01/02.
//
import ComposableArchitecture
import SwiftUI

@main
struct TCACounterApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(
                store: Store (
                    initialState: CounterFeature.State(count: 25)
                ) {
                    CounterFeature()
                }
            )
        }
    }
}


