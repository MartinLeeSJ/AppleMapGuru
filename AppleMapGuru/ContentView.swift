//
//  ContentView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI
import MapKit

enum MapConfig: String, CaseIterable, Identifiable {
    case standard = "standard", hybrid, imagery
    
    var id: Self { self }
    
    var firstUpperCased: String {
        switch self {
        case .standard, .hybrid, .imagery:
            return self.rawValue.prefix(1).capitalized + self.rawValue.dropFirst()
        }
    }
    
    var mkmapConfig: MKMapConfiguration {
        switch self {
        case .standard: return MKStandardMapConfiguration()
        case .hybrid: return MKHybridMapConfiguration()
        case .imagery: return MKImageryMapConfiguration()
        }
    }
    
}

struct ContentView: View {
    @State private var mapConfig: MapConfig = .standard
    
    @State private var showSearchSheet: Bool = true
    @State private var showMapConfigSheet: Bool = false
    
    @State private var sheetHeight: PresentationDetent = .height(50)
    @State private var configSheetHeight: PresentationDetent = .medium
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                let width = geo.size.width
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
                            .padding(.vertical, height * 0.08)
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
                SearchSheetView(searchText: $searchText)
                    .interactiveDismissDisabled(!showMapConfigSheet)
                    .presentationDetents(
                        undimmed: [.height(20), .height(100), .medium, .large],
                        selection: $sheetHeight
                    )
            }
            
            
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

struct SearchSheetView: View {
    @Binding var searchText: String
    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer,
                prompt: "장소 및 주소검색"
            )
            
        }
    }
}

struct MapConfigSheetView: View {
    @Binding var mapConfig: MapConfig
    var body: some View {
        HStack {
            Button {
                mapConfig = .standard
            } label: {
                Text("일반지도")
            }
            
            Button {
                mapConfig = .hybrid
            } label: {
                Text("하이브리드")
            }
            
            Button {
                mapConfig = .imagery
            } label: {
                Text("위성")
            }

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
