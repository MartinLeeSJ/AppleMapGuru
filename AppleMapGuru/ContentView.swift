//
//  ContentView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI
import MapKit

enum MapConfig: String, CaseIterable, Identifiable {
    case standard = "standard"
    case hybrid, imagery
    
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
    
    var body: some View {
        GeometryReader { geo in
            let width = geo.size.width
            
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                MapView(mapConfig: $mapConfig)
                    .edgesIgnoringSafeArea(.vertical)
                    .overlay(alignment: .top) {
                        Picker(selection: $mapConfig) {
                            ForEach(MapConfig.allCases) { map in
                                Text(map.firstUpperCased)
                            }
                        } label: {
                            Text("보이는 맵 종류 설정")
                        }
                    .pickerStyle(.segmented)
                    .frame(width: width * 0.7)

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
