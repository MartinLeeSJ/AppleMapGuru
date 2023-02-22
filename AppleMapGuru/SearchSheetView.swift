//
//  SearchSheetView.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/23.
//

import SwiftUI

struct SearchSheetView: View {
    @StateObject var searchVM: SearchViewModel = SearchViewModel()
    var sheetHeight: PresentationDetent
    
    
    var body: some View {
        NavigationStack {
            VStack {
                if sheetHeight != .height(20) {
                    TextField("\(Image(systemName: "magnifyingglass")) 장소 및 주소 검색", text: $searchVM.searchText)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(uiColor: .systemGray6))
                        }
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                        .onSubmit {
                            searchVM.search(for: searchVM.searchText)
                        }
                }
                List {
                    ForEach(searchVM.places ?? [], id: \.self) { place in
                        Text(place.name ?? "아무장소")
                    }
                }
            }
            .padding()
            
        }
        .navigationBarTitle(Text("장소검색"))
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top, 10)
        
    }
    
    
}


struct SearchSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSheetView(sheetHeight: .height(50))
    }
}
