//
//  SearchViewModel.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/23.
//

import Foundation
import MapKit

final class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var localSearch: MKLocalSearch? = nil
    @Published var places: [MKMapItem]? = nil
    
    func search(for queryString: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = queryString
    }
    
    func search(using searchRequest: MKLocalSearch.Request) {
        searchRequest.resultTypes = .pointOfInterest
        localSearch = MKLocalSearch(request: searchRequest)
       
        localSearch?.start { (response, error) in
            guard error == nil else {
                print(error ?? "")
                return
            }
            
            self.places = response?.mapItems
        }
    }
}
