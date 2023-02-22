//
//  LocationService.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/23.
//

import Foundation
import CoreLocation
import UIKit

final class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    private let locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    private func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) async {
        lastSeenLocation = locations.first
        await fetchCountryAndCity(for: locations.first)
    }

    func fetchCountryAndCity(for location: CLLocation?) async {
        guard let location = location else { return }
        do {
            let geocoder = CLGeocoder()
            self.currentPlacemark = try await geocoder.reverseGeocodeLocation(location).first
        } catch {
            print(error.localizedDescription)
        }
    }

    
    
}
