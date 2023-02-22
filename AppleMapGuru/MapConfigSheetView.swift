//
//  MapConfigSheetView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/23.
//

import SwiftUI

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

struct MapConfigSheetView_Previews: PreviewProvider {
    static var previews: some View {
        MapConfigSheetView(mapConfig: .constant(.imagery))
    }
}
