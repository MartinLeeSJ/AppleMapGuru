//
//  Ex+View.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI

extension View {

    func presentationDetents(
        undimmed detents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil
    ) -> some View {
        self.background(UndimmedDetentView(largestUndimmed: largestUndimmed ?? detents.last))
            .presentationDetents(detents.swiftUISet)
    }

    func presentationDetents(
        undimmed detents: [UndimmedPresentationDetent],
        largestUndimmed: UndimmedPresentationDetent? = nil,
        selection: Binding<PresentationDetent>
    ) -> some View {
        self.background(UndimmedDetentView(largestUndimmed: largestUndimmed ?? detents.last))
            .presentationDetents(
                Set(detents.swiftUISet),
                selection: selection
            )
    }
}
