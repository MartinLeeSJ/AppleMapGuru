//
//  MapView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI
import MapKit

final class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapViewCoordinator: MapView
    
    init(_ control: MapView) {
        self.mapViewCoordinator = control
    }
}

struct MapView: UIViewRepresentable {
    @Binding var mapConfig: MapConfig
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        
        mapView.layoutMargins = UIEdgeInsets(top: 30, left: 10, bottom: 30.0, right: 10)
        mapView.showsScale = true
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.preferredConfiguration = mapConfig.mkmapConfig
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        MapViewCoordinator(self)
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapConfig: .constant(MapConfig.standard))
    }
}
