//
//  Ex+Collection.swift
//  AppleMapGuru
//
//  Created by Martin on 2023/02/20.
//

import SwiftUI

extension Collection where Element == UndimmedPresentationDetent {
    var swiftUISet: Set<PresentationDetent> {
        Set(map { $0.swiftUIDetent })
    }
}
