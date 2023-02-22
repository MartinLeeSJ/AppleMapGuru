//
//  ContentView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI
import MapKit


struct ContentView: View {
    
    @ObservedObject var locationService = LocationService()
    
    @State private var mapConfig: MapConfig = .standard
    
    @State private var showSearchSheet: Bool = true
    @State private var showMapConfigSheet: Bool = false
    
    @State private var searchSheetHeight: PresentationDetent = .height(80)
    @State private var configSheetHeight: PresentationDetent = .medium
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let height = geo.size.height
                
                ZStack {
                    Color.black
                        .edgesIgnoringSafeArea(.all)
                    
                    MapView(mapConfig: $mapConfig)
                        .edgesIgnoringSafeArea(.vertical)
                        .overlay(alignment: .topTrailing) {
                            Button {
                                showMapConfigSheet = true
                            } label: {
                                buttonImage
                                    .font(.title3)
                                    .padding(10)
                                    .background {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white.opacity(0.8))
                                    }
                            }
                            .padding(.vertical, height * 0.1)
                            .padding(.horizontal, 20)
                            .sheet(isPresented: $showMapConfigSheet) {
                                MapConfigSheetView(mapConfig: $mapConfig)
                                    .interactiveDismissDisabled(false)
                                    .presentationDetents(
                                        undimmed: [.medium, .large],
                                        largestUndimmed: .height(20),
                                        selection: $configSheetHeight
                                    )
                            }
                        }
                }
            }
            .sheet(isPresented: $showSearchSheet) {
                SearchSheetView(sheetHeight: searchSheetHeight)
                    .interactiveDismissDisabled(!showMapConfigSheet)
                    .presentationDetents(
                        undimmed: [.height(20), .height(80), .medium, .large],
                        selection: $searchSheetHeight
                    )
            }
            
            
        }
        .navigationTitle("Maps")
        .onAppear {
            locationService.requestPermission()
        }
    }
    
    var buttonImage: some View {
        switch mapConfig {
        case .standard:
            return Image(systemName: "map")
        case .hybrid:
            return Image(systemName: "network")
        case .imagery:
            return Image(systemName: "globe.asia.australia.fill")
        }
    }
    
    
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ContentView()
        }
    }
}
