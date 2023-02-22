//
//  MapConfig.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/23.
//

import Foundation
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
