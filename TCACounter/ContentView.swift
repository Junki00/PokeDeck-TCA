//
//  ContentView.swift
//  TCACounter
//
//  Created by drx on 2026/01/02.
//
import ComposableArchitecture
import SwiftUI

struct ContentView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {

                    // MARK: - Core Paging View (Top Aligned)
                    TabView(selection: Binding(
                        get: { store.count },
                        set: { newValue in
                            if newValue > store.count {
                                store.send(.increment)
                            } else if newValue < store.count {
                                store.send(.decrement)
                            }
                        }
                    )) {
                        ForEach(1...1025, id: \.self) { id in
                            // MARK: - Animation Fix (ZStack Strategy)
                            // Instead of swapping views (if/else), we stack them.
                            // The Placeholder is ALWAYS there. The RealCard fades in on top.
                            // This prevents any directional "bouncing" glitches during the swipe.
                            ZStack {
                                PlaceholderCardView(id: id)
                                
                                if id == store.count {
                                    RealCardView(store: store)
                                        // Force a seamless cross-dissolve animation
                                        .transition(.opacity.animation(.easeInOut(duration: 0.2)))
                                }
                            }
                            .padding(.horizontal, 20)
                            // Reduced bottom padding to bring the hint text closer
                            .padding(.bottom, 20)
                            .tag(id)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 480)
                    
                    // MARK: - Swipe Hint
                    // Placed tightly below the card area
                    HStack(spacing: 10) {
                        Image(systemName: "chevron.left.circle.fill")
                            .opacity(store.count > 1 ? 0.3 : 0)
                        
                        Text("Swipe for next")
                            .font(.caption)
                            .textCase(.uppercase)
                            .foregroundStyle(.secondary)
                        
                        Image(systemName: "chevron.right.circle.fill")
                            .opacity(0.3)
                    }
                    // Minimal top padding to visually connect with the card
                    .padding(.top, 0)
                    
                    Spacer()
                    
                    // MARK: - Random Action Button
                    Button {
                        withAnimation {
                            let generator = UIImpactFeedbackGenerator(style: .heavy)
                            generator.impactOccurred()
                            
                            _ = store.send(.randomButtonTapped)
                        }
                    } label: {
                        HStack {
                            Image(systemName: "dice.fill")
                            Text("Random Encounter")
                        }
                        .font(.headline)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.gradient)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .shadow(color: .blue.opacity(0.4), radius: 10, y: 5)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Pokémon: No. \(String(format: "%04d", store.count))")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            store.send(.onAppear)
        }
        .sensoryFeedback(.selection, trigger: store.count)
    }
}

// MARK: - Real Data Card
struct RealCardView: View {
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Background Watermark Number
            // Consistent positioning with Placeholder
            Text(String(format: "#%04d", store.count))
                .font(.system(size: 90, weight: .black, design: .rounded))
                .foregroundStyle(.tertiary.opacity(0.1)) // Subtle opacity
                .padding(.top, 20)
                .allowsHitTesting(false)
            
            VStack(spacing: 0) {
                // Top Half: Image Container
                ZStack {
                    if let imageURL = store.imageURL {
                        AsyncImage(url: imageURL) { phase in
                            if let image = phase.image {
                                image.resizable().aspectRatio(contentMode: .fit)
                            } else if phase.error != nil {
                                Image(systemName: "exclamationmark.triangle")
                                    .font(.largeTitle).foregroundStyle(.secondary)
                            } else {
                                ProgressView()
                            }
                        }
                    } else {
                        Image(systemName: "questionmark.circle.fill")
                            .resizable().aspectRatio(contentMode: .fit)
                            .foregroundStyle(.tertiary)
                            .padding(40)
                    }
                }
                .frame(height: 380) // Fixed height matches placeholder
                .frame(maxWidth: .infinity)
                .clipped() // Ensures image doesn't bleed out
                
                Divider()
                
                // Bottom Half: Info Container
                VStack(spacing: 12) {
                    Text(store.fact ?? "Loading...")
                        .font(.system(size: 32, weight: .heavy, design: .rounded))
                        .foregroundStyle(.primary)
                        .multilineTextAlignment(.center)
                        .minimumScaleFactor(0.6)
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
        // Ensures content adheres to the corner radius
        .mask(RoundedRectangle(cornerRadius: 32, style: .continuous))
    }
}

// MARK: - Placeholder Card (Optimized)
struct PlaceholderCardView: View {
    let id: Int
    
    var body: some View {
        ZStack(alignment: .top) {
            
            // Background Watermark Number
            // Aligned exactly like RealCardView to prevent visual jumping
            Text(String(format: "#%04d", id))
                .font(.system(size: 90, weight: .black, design: .rounded))
                .foregroundStyle(.tertiary.opacity(0.1))
                .padding(.top, 20)
            
            VStack(spacing: 0) {
                // Top Half: Placeholder Image Area
                ZStack {
                    Image(systemName: "circle.dotted")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                        .foregroundStyle(.tertiary.opacity(0.4))
                }
                .frame(height: 380) // MATCHES RealCardView height (Critical)
                .frame(maxWidth: .infinity)
                
                Divider() // Keep the visual structure identical
                
                // Bottom Half: Skeleton Loader for Text
                VStack(spacing: 12) {
                    // Simulated Text Lines
                    Capsule()
                        .fill(.tertiary.opacity(0.2))
                        .frame(width: 180, height: 30)
                    
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
        // No shadow to indicate "inactive" state
    }
}

#Preview {
    ContentView(
        store: Store(
            initialState: CounterFeature.State(count: 25)
        ) {
            CounterFeature()
        }
    )
}
